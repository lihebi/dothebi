# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}" HEBI
# PDF: a.pdf

{BufferedProcess} = require 'atom'
atom.grammars.loadGrammar "#{process.env['ATOM_HOME']}/globalGrammar.cson"
atom.grammars.loadGrammar "#{process.env['ATOM_HOME']}/commentGrammar.cson"

atom.contextMenu.add {
  'atom-text-editor': [{
      label: 'Smart Scholar'
      command: 'hebi:scholar'
    }]
}

matchPDF = (line) ->
  url = line.match(/PDF: ([^\s]+)/)
  return if not url? or not url.length? or url.length<2
  url = url[1]
  path = atom.workspace.getActiveTextEditor().getPath()
  path = path.substring(0, path.lastIndexOf('/'))
  url = "#{path}/#{url}"
  command = "open"
  args = ['-a', 'Preview', url]
  new BufferedProcess({command, args})

matchTitle = (line) ->
  title = line.match(/title\s*=\s*{([^}]*)}/)
  return if not title? or not title.length? or title.length<2
  title = title[1]
  command = "open"
  args = ["https://scholar.google.com/scholar?hl=en&q=#{title}"]
  new BufferedProcess({command, args})

matchAuthor = (line, column) ->
  authors = line.match(/author={([^}]*)}/)
  return if not authors? or not authors.length? or authors.length<2
  authors = authors[1]
  authors = authors.split('and')
  return if not authors? or not authors.length? or authors.length<1
  result = ''
  for author in authors
    do (author) ->
      if line.indexOf(author) <= column
        result = author
  command = "open"
  args = [encodeURI("https://www.google.com/#q=#{result}")]
  console.log args
  new BufferedProcess({command, args})

atom.commands.add 'atom-text-editor', 'hebi:Smart Scholar', ->
  Editor = atom.workspace.getActiveTextEditor()
  Cursor = Editor.getLastCursor()
  line = Cursor.getCurrentBufferLine()
  column = Cursor.getBufferColumn()
  console.log line
  matchPDF(line)
  matchTitle(line)
  matchAuthor(line, column)

# atom.contextMenu.add {
#   'atom-workspace': [{label: 'Help', command: 'application:open-documentation'}]
#   'atom-text-editor': [{
#     label: 'History',
#     submenu: [
#       {label: 'Undo', command:'core:undo'}
#       {label: 'Redo', command:'core:redo'}
#     ]
#   }]
# }

# switch between two pane items
lastItem = null
currentItem = atom.workspace.getActivePaneItem()

atom.workspace.onDidChangeActivePaneItem (item) ->
  lastItem = currentItem
  currentItem = item

atom.contextMenu.add {
  'atom-text-editor': [{
      label: 'Switch to Last Pane Item'
      command: 'hebi:switch-pane-item'
    }]
}

atom.commands.add 'atom-text-editor', 'hebi:switch-pane-item', ->
  pane = atom.workspace.getActivePane()
  pane.activateItem(lastItem)
