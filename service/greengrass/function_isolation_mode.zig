/// Specifies whether the Lambda function runs in a Greengrass container
/// (default) or without containerization. Unless your scenario requires that
/// you run without containerization, we recommend that you run in a Greengrass
/// container. Omit this value to run the Lambda function with the default
/// containerization for the group.
pub const FunctionIsolationMode = enum {
    greengrass_container,
    no_container,

    pub const json_field_names = .{
        .greengrass_container = "GreengrassContainer",
        .no_container = "NoContainer",
    };
};
