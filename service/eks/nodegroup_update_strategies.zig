pub const NodegroupUpdateStrategies = enum {
    default,
    minimal,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .minimal = "MINIMAL",
    };
};
