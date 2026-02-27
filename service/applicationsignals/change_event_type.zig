pub const ChangeEventType = enum {
    deployment,
    configuration,

    pub const json_field_names = .{
        .deployment = "DEPLOYMENT",
        .configuration = "CONFIGURATION",
    };
};
