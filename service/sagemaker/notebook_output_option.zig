pub const NotebookOutputOption = enum {
    allowed,
    disabled,

    pub const json_field_names = .{
        .allowed = "Allowed",
        .disabled = "Disabled",
    };
};
