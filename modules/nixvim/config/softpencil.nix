{
  autoGroups.softpencil_defaults = {
    clear = true;
  };

  autoCmd = [
    {
      event = [ "FileType" ];
      group = "softpencil_defaults";
      pattern = [
        "markdown"
        "text"
        "tex"
        "plaintex"
        "asciidoc"
        "rst"
        "lean"
      ];
      command = "SoftPencil";
      desc = "softpencil for prose-like filetypes";
    }
  ];
}
