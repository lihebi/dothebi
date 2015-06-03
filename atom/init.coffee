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
atom.grammars.loadGrammar "#{process.env['ATOM_HOME']}/grammar.cson"

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
  url = "#{atom.project.getPath()}/#{url}"
  command = "open"
  args = ['-a', 'Preview', url]
  new BufferedProcess({command, args})

matchTitle = (line) ->
  title = line.match(/title={([^}]*)}/)
  return if not title? or not title.length? or title.length<2
  title = title[1]
  command = "open"
  args = ['-a', 'Google Chrome', "https://scholar.google.com/scholar?hl=en&q=#{title}"]
  new BufferedProcess({command, args})

atom.commands.add 'atom-text-editor', 'hebi:scholar', ->
  Editor = atom.workspace.getActiveTextEditor()
  Cursor = Editor.getLastCursor()
  line = Cursor.getCurrentBufferLine()
  console.log line
  matchPDF(line)
  matchTitle(line)

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
