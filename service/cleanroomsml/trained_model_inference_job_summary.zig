const LogsStatus = @import("logs_status.zig").LogsStatus;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const TrainedModelInferenceJobStatus = @import("trained_model_inference_job_status.zig").TrainedModelInferenceJobStatus;

/// Provides information about the trained model inference job.
pub const TrainedModelInferenceJobSummary = struct {
    /// The collaboration ID of the collaboration that contains the trained model
    /// inference job.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that is used for the trained model inference job.
    configured_model_algorithm_association_arn: ?[]const u8,

    /// The time at which the trained model inference job was created.
    create_time: i64,

    /// The description of the trained model inference job.
    description: ?[]const u8,

    /// The log status of the trained model inference job.
    logs_status: ?LogsStatus,

    /// Details about the log status for the trained model inference job.
    logs_status_details: ?[]const u8,

    /// The membership ID of the membership that contains the trained model
    /// inference job.
    membership_identifier: []const u8,

    /// The metric status of the trained model inference job.
    metrics_status: ?MetricsStatus,

    /// Details about the metrics status for the trained model inference job.
    metrics_status_details: ?[]const u8,

    /// The name of the trained model inference job.
    name: []const u8,

    /// The output configuration information of the trained model job.
    output_configuration: InferenceOutputConfiguration,

    /// The status of the trained model inference job.
    status: TrainedModelInferenceJobStatus,

    /// The Amazon Resource Name (ARN) of the trained model that is used for the
    /// trained model inference job.
    trained_model_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model inference job.
    trained_model_inference_job_arn: []const u8,

    /// The version identifier of the trained model that was used for inference in
    /// this job.
    trained_model_version_identifier: ?[]const u8,

    /// The most recent time at which the trained model inference job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .description = "description",
        .logs_status = "logsStatus",
        .logs_status_details = "logsStatusDetails",
        .membership_identifier = "membershipIdentifier",
        .metrics_status = "metricsStatus",
        .metrics_status_details = "metricsStatusDetails",
        .name = "name",
        .output_configuration = "outputConfiguration",
        .status = "status",
        .trained_model_arn = "trainedModelArn",
        .trained_model_inference_job_arn = "trainedModelInferenceJobArn",
        .trained_model_version_identifier = "trainedModelVersionIdentifier",
        .update_time = "updateTime",
    };
};
