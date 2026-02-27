pub const ScopeType = enum {
    instance_id,
    rules_package_arn,

    pub const json_field_names = .{
        .instance_id = "INSTANCE_ID",
        .rules_package_arn = "RULES_PACKAGE_ARN",
    };
};
