pub const ControlType = enum {
    standard,
    custom,
    core,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .custom = "CUSTOM",
        .core = "CORE",
    };
};
