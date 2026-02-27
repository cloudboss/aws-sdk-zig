pub const StreamView = enum {
    app,
    desktop,

    pub const json_field_names = .{
        .app = "APP",
        .desktop = "DESKTOP",
    };
};
