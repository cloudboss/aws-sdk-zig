pub const ToolbarType = enum {
    floating,
    docked,

    pub const json_field_names = .{
        .floating = "FLOATING",
        .docked = "DOCKED",
    };
};
