const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;
const EvaluationResultIdentifier = @import("evaluation_result_identifier.zig").EvaluationResultIdentifier;

/// The details of a conformance pack evaluation. Provides Config rule and
/// Amazon Web Services resource type that was evaluated, the compliance of the
/// conformance pack, related time stamps, and supplementary information.
pub const ConformancePackEvaluationResult = struct {
    /// Supplementary information about how the evaluation determined the
    /// compliance.
    annotation: ?[]const u8,

    /// The compliance type. The allowed values are `COMPLIANT` and `NON_COMPLIANT`.
    /// `INSUFFICIENT_DATA` is not supported.
    compliance_type: ConformancePackComplianceType,

    /// The time when Config rule evaluated Amazon Web Services resource.
    config_rule_invoked_time: i64,

    evaluation_result_identifier: EvaluationResultIdentifier,

    /// The time when Config recorded the evaluation result.
    result_recorded_time: i64,

    pub const json_field_names = .{
        .annotation = "Annotation",
        .compliance_type = "ComplianceType",
        .config_rule_invoked_time = "ConfigRuleInvokedTime",
        .evaluation_result_identifier = "EvaluationResultIdentifier",
        .result_recorded_time = "ResultRecordedTime",
    };
};
