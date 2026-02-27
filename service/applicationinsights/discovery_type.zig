pub const DiscoveryType = enum {
    resource_group_based,
    account_based,

    pub const json_field_names = .{
        .resource_group_based = "RESOURCE_GROUP_BASED",
        .account_based = "ACCOUNT_BASED",
    };
};
