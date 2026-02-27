pub const GroupFilterName = enum {
    resource_type,
    configuration_type,
    owner,
    display_name,
    criticality,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .configuration_type = "ConfigurationType",
        .owner = "Owner",
        .display_name = "DisplayName",
        .criticality = "Criticality",
    };
};
