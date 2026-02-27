pub const ConfigurationType = enum {
    default,
    custom,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .custom = "CUSTOM",
    };
};
