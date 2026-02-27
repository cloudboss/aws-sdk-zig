pub const ProtectionGroupPattern = enum {
    all,
    arbitrary,
    by_resource_type,

    pub const json_field_names = .{
        .all = "ALL",
        .arbitrary = "ARBITRARY",
        .by_resource_type = "BY_RESOURCE_TYPE",
    };
};
