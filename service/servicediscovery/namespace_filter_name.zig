pub const NamespaceFilterName = enum {
    @"type",
    name,
    http_name,
    resource_owner,

    pub const json_field_names = .{
        .@"type" = "TYPE",
        .name = "NAME",
        .http_name = "HTTP_NAME",
        .resource_owner = "RESOURCE_OWNER",
    };
};
