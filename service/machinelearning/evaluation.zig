const PerformanceMetrics = @import("performance_metrics.zig").PerformanceMetrics;
const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Represents the output of `GetEvaluation` operation.
///
/// The content consists of the detailed metadata and data file information and
/// the current status of the
/// `Evaluation`.
pub const Evaluation = struct {
    compute_time: ?i64,

    /// The time that the `Evaluation` was created. The time is expressed in epoch
    /// time.
    created_at: ?i64,

    /// The AWS user account that invoked the evaluation. The account type can be
    /// either an AWS root account or an AWS Identity and Access Management (IAM)
    /// user account.
    created_by_iam_user: ?[]const u8,

    /// The ID of the `DataSource` that is used to evaluate the `MLModel`.
    evaluation_data_source_id: ?[]const u8,

    /// The ID that is assigned to the `Evaluation` at creation.
    evaluation_id: ?[]const u8,

    finished_at: ?i64,

    /// The location and name of the data in Amazon Simple Storage Server (Amazon
    /// S3) that is used in the evaluation.
    input_data_location_s3: ?[]const u8,

    /// The time of the most recent edit to the `Evaluation`. The time is expressed
    /// in epoch time.
    last_updated_at: ?i64,

    /// A description of the most recent details about evaluating the `MLModel`.
    message: ?[]const u8,

    /// The ID of the `MLModel` that is the focus of the evaluation.
    ml_model_id: ?[]const u8,

    /// A user-supplied name or description of the `Evaluation`.
    name: ?[]const u8,

    /// Measurements of how well the `MLModel` performed, using observations
    /// referenced
    /// by the `DataSource`. One of the following metrics is returned, based on the
    /// type of the `MLModel`:
    ///
    /// * BinaryAUC: A binary `MLModel` uses the Area Under the Curve (AUC)
    ///   technique to measure performance.
    ///
    /// * RegressionRMSE: A regression `MLModel` uses the Root Mean Square Error
    ///   (RMSE) technique to measure performance. RMSE measures the difference
    ///   between predicted and actual values for a single variable.
    ///
    /// * MulticlassAvgFScore: A multiclass `MLModel` uses the F1 score technique to
    ///   measure performance.
    ///
    /// For more information about performance metrics, please see the [Amazon
    /// Machine Learning Developer
    /// Guide](https://docs.aws.amazon.com/machine-learning/latest/dg).
    performance_metrics: ?PerformanceMetrics,

    started_at: ?i64,

    /// The status of the evaluation. This element can have one of the following
    /// values:
    ///
    /// * `PENDING` - Amazon Machine Learning (Amazon ML) submitted a request to
    ///   evaluate an `MLModel`.
    ///
    /// * `INPROGRESS` - The evaluation is underway.
    ///
    /// * `FAILED` - The request to evaluate an `MLModel` did not run to completion.
    ///   It is not usable.
    ///
    /// * `COMPLETED` - The evaluation process completed successfully.
    ///
    /// * `DELETED` - The `Evaluation` is marked as deleted. It is not usable.
    status: ?EntityStatus,

    pub const json_field_names = .{
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .evaluation_data_source_id = "EvaluationDataSourceId",
        .evaluation_id = "EvaluationId",
        .finished_at = "FinishedAt",
        .input_data_location_s3 = "InputDataLocationS3",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .ml_model_id = "MLModelId",
        .name = "Name",
        .performance_metrics = "PerformanceMetrics",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
