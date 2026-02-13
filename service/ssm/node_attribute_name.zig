pub const NodeAttributeName = enum {
    agent_version,
    platform_name,
    platform_type,
    platform_version,
    region,
    resource_type,

    pub const json_field_names = .{
        .agent_version = "AGENT_VERSION",
        .platform_name = "PLATFORM_NAME",
        .platform_type = "PLATFORM_TYPE",
        .platform_version = "PLATFORM_VERSION",
        .region = "REGION",
        .resource_type = "RESOURCE_TYPE",
    };
};
