pub const CodeSigningPolicy = enum {
    warn,
    enforce,

    pub const json_field_names = .{
        .warn = "Warn",
        .enforce = "Enforce",
    };
};
