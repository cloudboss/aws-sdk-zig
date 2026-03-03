const Compliance = @import("compliance.zig").Compliance;

/// Indicates whether an Config rule is compliant based on
/// account ID, region, compliance, and rule name.
///
/// A rule is compliant if all of the resources that the rule
/// evaluated comply with it. It is noncompliant if any of these
/// resources do not comply.
pub const AggregateComplianceByConfigRule = struct {
    /// The 12-digit account ID of the source account.
    account_id: ?[]const u8 = null,

    /// The source region from where the data is aggregated.
    aws_region: ?[]const u8 = null,

    /// Indicates whether an Amazon Web Services resource or Config rule is
    /// compliant and provides the number of contributors that affect the
    /// compliance.
    compliance: ?Compliance = null,

    /// The name of the Config rule.
    config_rule_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .compliance = "Compliance",
        .config_rule_name = "ConfigRuleName",
    };
};
