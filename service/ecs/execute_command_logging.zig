pub const ExecuteCommandLogging = enum {
    none,
    default,
    override,

    pub const json_field_names = .{
        .none = "NONE",
        .default = "DEFAULT",
        .override = "OVERRIDE",
    };
};
