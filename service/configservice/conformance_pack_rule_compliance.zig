const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Compliance information of one or more Config rules within a conformance
/// pack. You can filter using Config rule names and compliance types.
pub const ConformancePackRuleCompliance = struct {
    /// Compliance of the Config rule.
    compliance_type: ?ConformancePackComplianceType,

    /// Name of the Config rule.
    config_rule_name: ?[]const u8,

    /// Controls for the conformance pack. A control is a process to prevent or
    /// detect problems while meeting objectives.
    /// A control can align with a specific compliance regime or map to internal
    /// controls defined by an organization.
    controls: ?[]const []const u8,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .config_rule_name = "ConfigRuleName",
        .controls = "Controls",
    };
};
