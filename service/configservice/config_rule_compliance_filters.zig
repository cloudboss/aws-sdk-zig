const ComplianceType = @import("compliance_type.zig").ComplianceType;

/// Filters the compliance results based on account ID, region,
/// compliance type, and rule name.
pub const ConfigRuleComplianceFilters = struct {
    /// The 12-digit account ID of the source account.
    account_id: ?[]const u8,

    /// The source region where the data is aggregated.
    aws_region: ?[]const u8,

    /// The rule compliance status.
    ///
    /// For the `ConfigRuleComplianceFilters` data type, Config supports only
    /// `COMPLIANT` and
    /// `NON_COMPLIANT`. Config does not support the
    /// `NOT_APPLICABLE` and the
    /// `INSUFFICIENT_DATA` values.
    compliance_type: ?ComplianceType,

    /// The name of the Config rule.
    config_rule_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .compliance_type = "ComplianceType",
        .config_rule_name = "ConfigRuleName",
    };
};
