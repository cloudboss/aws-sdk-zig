const Compliance = @import("compliance.zig").Compliance;

/// Indicates whether an Config rule is compliant. A rule is
/// compliant if all of the resources that the rule evaluated comply
/// with it. A rule is noncompliant if any of these resources do not
/// comply.
pub const ComplianceByConfigRule = struct {
    /// Indicates whether the Config rule is compliant.
    compliance: ?Compliance,

    /// The name of the Config rule.
    config_rule_name: ?[]const u8,

    pub const json_field_names = .{
        .compliance = "Compliance",
        .config_rule_name = "ConfigRuleName",
    };
};
