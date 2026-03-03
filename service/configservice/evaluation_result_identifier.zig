const EvaluationResultQualifier = @import("evaluation_result_qualifier.zig").EvaluationResultQualifier;

/// Uniquely identifies an evaluation result.
pub const EvaluationResultIdentifier = struct {
    /// Identifies an Config rule used to evaluate an Amazon Web Services resource,
    /// and provides the type and ID of the evaluated resource.
    evaluation_result_qualifier: ?EvaluationResultQualifier = null,

    /// The time of the event that triggered the evaluation of your Amazon Web
    /// Services
    /// resources. The time can indicate when Config delivered a
    /// configuration item change notification, or it can indicate when Config
    /// delivered the configuration snapshot, depending on which
    /// event triggered the evaluation.
    ordering_timestamp: ?i64 = null,

    /// A Unique ID for an evaluation result.
    resource_evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluation_result_qualifier = "EvaluationResultQualifier",
        .ordering_timestamp = "OrderingTimestamp",
        .resource_evaluation_id = "ResourceEvaluationId",
    };
};
