pub const ServiceActionDefinitionKey = enum {
    name,
    version,
    assume_role,
    parameters,

    pub const json_field_names = .{
        .name = "Name",
        .version = "Version",
        .assume_role = "AssumeRole",
        .parameters = "Parameters",
    };
};
