pub const HostnameTypeEnum = enum {
    ip_name,
    resource_name,

    pub const json_field_names = .{
        .ip_name = "IP_NAME",
        .resource_name = "RESOURCE_NAME",
    };
};
