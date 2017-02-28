CuentaPalabrasView = require './cuenta-palabras-view'
{CompositeDisposable} = require 'atom'

module.exports = CuentaPalabras =
  cuentaPalabrasView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cuentaPalabrasView = new CuentaPalabrasView(state.cuentaPalabrasViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cuentaPalabrasView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cuenta-palabras:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cuentaPalabrasView.destroy()

  serialize: ->
    cuentaPalabrasViewState: @cuentaPalabrasView.serialize()

  toggle: ->
    if @modalPanel.isVisible()

    else
      return unless editor = atom.workspace.getActiveTextEditor()

      words = editor.getText().split(/\s+/).length
      @cuentaPalabrasView.setCount(words)
      @modalPanel.show()
