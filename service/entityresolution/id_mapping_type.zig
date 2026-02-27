pub const IdMappingType = enum {
    provider,
    rule_based,

    pub const json_field_names = .{
        .provider = "PROVIDER",
        .rule_based = "RULE_BASED",
    };
};
