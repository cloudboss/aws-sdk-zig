const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Filters the conformance pack by compliance types and Config rule names.
pub const ConformancePackComplianceFilters = struct {
    /// Filters the results by compliance.
    ///
    /// The allowed values are `COMPLIANT` and `NON_COMPLIANT`. `INSUFFICIENT_DATA`
    /// is not supported.
    compliance_type: ?ConformancePackComplianceType = null,

    /// Filters the results by Config rule names.
    config_rule_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .config_rule_names = "ConfigRuleNames",
    };
};
