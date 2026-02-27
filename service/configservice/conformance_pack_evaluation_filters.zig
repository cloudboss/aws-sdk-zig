const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Filters a conformance pack by Config rule names, compliance types, Amazon
/// Web Services resource types, and resource IDs.
pub const ConformancePackEvaluationFilters = struct {
    /// Filters the results by compliance.
    ///
    /// The allowed values are `COMPLIANT` and `NON_COMPLIANT`. `INSUFFICIENT_DATA`
    /// is not supported.
    compliance_type: ?ConformancePackComplianceType,

    /// Filters the results by Config rule names.
    config_rule_names: ?[]const []const u8,

    /// Filters the results by resource IDs.
    ///
    /// This is valid only when you provide resource type. If there is no resource
    /// type, you will see an error.
    resource_ids: ?[]const []const u8,

    /// Filters the results by the resource type (for example,
    /// `"AWS::EC2::Instance"`).
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .config_rule_names = "ConfigRuleNames",
        .resource_ids = "ResourceIds",
        .resource_type = "ResourceType",
    };
};
