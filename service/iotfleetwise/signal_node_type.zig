pub const SignalNodeType = enum {
    sensor,
    actuator,
    attribute,
    branch,
    custom_struct,
    custom_property,

    pub const json_field_names = .{
        .sensor = "SENSOR",
        .actuator = "ACTUATOR",
        .attribute = "ATTRIBUTE",
        .branch = "BRANCH",
        .custom_struct = "CUSTOM_STRUCT",
        .custom_property = "CUSTOM_PROPERTY",
    };
};
