pub const LogScope = enum {
    customer,
    security_lake,
    cloudwatch_telemetry_rule_managed,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .security_lake = "SECURITY_LAKE",
        .cloudwatch_telemetry_rule_managed = "CLOUDWATCH_TELEMETRY_RULE_MANAGED",
    };
};
