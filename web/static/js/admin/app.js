class App  {
  constructor() {
    this.entry_preview = $("#entry_preview")
    this.entry_body = $("#entry_body")
    this.update_entry_preview($("#entry_body").val())
    this.key_bind(this)
  }

  key_bind() {
    var _this = this
    _this.entry_body.keyup(function(event) {
      _this.update_entry_preview(event.currentTarget.value);
    });
  }

  update_entry_preview(content) {
    this.entry_preview.html(
      marked(content)
    );
  }
}

$( () => new App )
export default App
