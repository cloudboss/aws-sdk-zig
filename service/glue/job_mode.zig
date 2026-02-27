pub const JobMode = enum {
    script,
    visual,
    notebook,

    pub const json_field_names = .{
        .script = "SCRIPT",
        .visual = "VISUAL",
        .notebook = "NOTEBOOK",
    };
};
