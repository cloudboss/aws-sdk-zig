pub const ParameterValueType = enum {
    default,
    custom,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .custom = "CUSTOM",
    };
};
