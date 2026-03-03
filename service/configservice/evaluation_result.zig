const ComplianceType = @import("compliance_type.zig").ComplianceType;
const EvaluationResultIdentifier = @import("evaluation_result_identifier.zig").EvaluationResultIdentifier;

/// The details of an Config evaluation. Provides the Amazon Web Services
/// resource that was evaluated, the compliance of the resource, related
/// time stamps, and supplementary information.
pub const EvaluationResult = struct {
    /// Supplementary information about how the evaluation determined
    /// the compliance.
    annotation: ?[]const u8 = null,

    /// Indicates whether the Amazon Web Services resource complies with the Config
    /// rule that evaluated it.
    ///
    /// For the `EvaluationResult` data type, Config
    /// supports only the `COMPLIANT`,
    /// `NON_COMPLIANT`, and `NOT_APPLICABLE` values.
    /// Config does not support the `INSUFFICIENT_DATA` value
    /// for the `EvaluationResult` data type.
    compliance_type: ?ComplianceType = null,

    /// The time when the Config rule evaluated the Amazon Web Services
    /// resource.
    config_rule_invoked_time: ?i64 = null,

    /// Uniquely identifies the evaluation result.
    evaluation_result_identifier: ?EvaluationResultIdentifier = null,

    /// The time when Config recorded the evaluation
    /// result.
    result_recorded_time: ?i64 = null,

    /// An encrypted token that associates an evaluation with an Config rule. The
    /// token identifies the rule, the Amazon Web Services resource being
    /// evaluated, and the event that triggered the evaluation.
    result_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .annotation = "Annotation",
        .compliance_type = "ComplianceType",
        .config_rule_invoked_time = "ConfigRuleInvokedTime",
        .evaluation_result_identifier = "EvaluationResultIdentifier",
        .result_recorded_time = "ResultRecordedTime",
        .result_token = "ResultToken",
    };
};
