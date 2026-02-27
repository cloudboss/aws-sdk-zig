const ComplianceType = @import("compliance_type.zig").ComplianceType;
const EvaluationResultIdentifier = @import("evaluation_result_identifier.zig").EvaluationResultIdentifier;

/// The details of an Config evaluation for an account ID and
/// region in an aggregator. Provides the Amazon Web Services resource that was
/// evaluated, the compliance of the resource, related time stamps, and
/// supplementary information.
pub const AggregateEvaluationResult = struct {
    /// The 12-digit account ID of the source account.
    account_id: ?[]const u8,

    /// Supplementary information about how the agrregate evaluation
    /// determined the compliance.
    annotation: ?[]const u8,

    /// The source region from where the data is aggregated.
    aws_region: ?[]const u8,

    /// The resource compliance status.
    ///
    /// For the `AggregationEvaluationResult` data type, Config supports only the
    /// `COMPLIANT` and
    /// `NON_COMPLIANT`. Config does not support the
    /// `NOT_APPLICABLE` and `INSUFFICIENT_DATA`
    /// value.
    compliance_type: ?ComplianceType,

    /// The time when the Config rule evaluated the Amazon Web Services
    /// resource.
    config_rule_invoked_time: ?i64,

    /// Uniquely identifies the evaluation result.
    evaluation_result_identifier: ?EvaluationResultIdentifier,

    /// The time when Config recorded the aggregate evaluation
    /// result.
    result_recorded_time: ?i64,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .annotation = "Annotation",
        .aws_region = "AwsRegion",
        .compliance_type = "ComplianceType",
        .config_rule_invoked_time = "ConfigRuleInvokedTime",
        .evaluation_result_identifier = "EvaluationResultIdentifier",
        .result_recorded_time = "ResultRecordedTime",
    };
};
