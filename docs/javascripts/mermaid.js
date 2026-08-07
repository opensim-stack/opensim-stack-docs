document$.subscribe(function () {
  if (window.mermaid) {
    window.mermaid.initialize({
      startOnLoad: false,
      securityLevel: "loose",
      theme: "dark"
    });

    var nodes = Array.prototype.slice
      .call(document.querySelectorAll(".mermaid"))
      .filter(function (node) {
        return !node.hasAttribute("data-processed");
      });

    if (nodes.length > 0) {
      window.mermaid.run({ nodes: nodes });
    }
  }
});
