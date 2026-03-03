const LogsStatus = @import("logs_status.zig").LogsStatus;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const TrainedModelInferenceJobStatus = @import("trained_model_inference_job_status.zig").TrainedModelInferenceJobStatus;

/// Provides summary information about a trained model inference job in a
/// collaboration.
pub const CollaborationTrainedModelInferenceJobSummary = struct {
    /// The collaboration ID of the collaboration that contains the trained model
    /// inference job.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that is used for the trained model inference job.
    configured_model_algorithm_association_arn: ?[]const u8 = null,

    /// The time at which the trained model inference job was created.
    create_time: i64,

    /// The account ID that created the trained model inference job.
    creator_account_id: []const u8,

    /// The description of the trained model inference job.
    description: ?[]const u8 = null,

    /// The trained model inference job logs status.
    logs_status: ?LogsStatus = null,

    /// Details about the logs status for the trained model inference job.
    logs_status_details: ?[]const u8 = null,

    /// The membership ID of the membership that contains the trained model
    /// inference job.
    membership_identifier: []const u8,

    /// the trained model inference job metrics status.
    metrics_status: ?MetricsStatus = null,

    /// Details about the metrics status for trained model inference job.
    metrics_status_details: ?[]const u8 = null,

    /// The name of the trained model inference job.
    name: []const u8,

    /// Returns output configuration information for the trained model inference
    /// job.
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
    trained_model_version_identifier: ?[]const u8 = null,

    /// The most recent time at which the trained model inference job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
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
