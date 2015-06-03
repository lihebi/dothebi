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
      label: 'Show PDF in Preview'
      command: 'hebi:open-pdf'
    }]
}
atom.commands.add 'atom-text-editor', 'hebi:open-pdf', ->
  Editor = atom.workspace.getActiveTextEditor()
  Cursor = Editor.getLastCursor()
  _lineContent = Cursor.getCurrentBufferLine()
  url = _lineContent.match(/PDF: ([^\s]+)/)
  return if not url? or not url.length? or url.length==1
  url = url[1]
  url = "#{atom.project.getPath()}/#{url}"
  # find url in _lineContent
  console.log url
  # open preview for the url
  command = "open"
  args = ['-a', 'Preview', url]
  new BufferedProcess({command, args})

atom.contextMenu.add {
  'atom-workspace': [{label: 'Help', command: 'application:open-documentation'}]
  'atom-text-editor': [{
    label: 'History',
    submenu: [
      {label: 'Undo', command:'core:undo'}
      {label: 'Redo', command:'core:redo'}
    ]
  }]
}
