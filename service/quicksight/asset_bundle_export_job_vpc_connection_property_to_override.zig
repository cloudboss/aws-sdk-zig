pub const AssetBundleExportJobVPCConnectionPropertyToOverride = enum {
    name,
    dns_resolvers,
    role_arn,

    pub const json_field_names = .{
        .name = "NAME",
        .dns_resolvers = "DNS_RESOLVERS",
        .role_arn = "ROLE_ARN",
    };
};
