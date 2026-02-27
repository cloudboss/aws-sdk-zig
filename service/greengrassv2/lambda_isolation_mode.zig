pub const LambdaIsolationMode = enum {
    greengrass_container,
    no_container,

    pub const json_field_names = .{
        .greengrass_container = "GREENGRASS_CONTAINER",
        .no_container = "NO_CONTAINER",
    };
};
