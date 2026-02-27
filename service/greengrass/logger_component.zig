pub const LoggerComponent = enum {
    greengrass_system,
    lambda,

    pub const json_field_names = .{
        .greengrass_system = "GreengrassSystem",
        .lambda = "Lambda",
    };
};
