const TrainedModelExportOutputConfiguration = @import("trained_model_export_output_configuration.zig").TrainedModelExportOutputConfiguration;
const TrainedModelExportJobStatus = @import("trained_model_export_job_status.zig").TrainedModelExportJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

/// Provides summary information about a trained model export job in a
/// collaboration.
pub const CollaborationTrainedModelExportJobSummary = struct {
    /// The collaboration ID of the collaboration that contains the trained model
    /// export job.
    collaboration_identifier: []const u8,

    /// The time at which the trained model export job was created.
    create_time: i64,

    /// The account ID of the member that created the trained model.
    creator_account_id: []const u8,

    /// The description of the trained model.
    description: ?[]const u8 = null,

    /// The membership ID of the member that created the trained model export job.
    membership_identifier: []const u8,

    /// The name of the trained model export job.
    name: []const u8,

    output_configuration: TrainedModelExportOutputConfiguration,

    /// The status of the trained model.
    status: TrainedModelExportJobStatus,

    status_details: ?StatusDetails = null,

    /// The Amazon Resource Name (ARN) of the trained model that is being exported.
    trained_model_arn: []const u8,

    /// The version identifier of the trained model that was exported in this job.
    trained_model_version_identifier: ?[]const u8 = null,

    /// The most recent time at which the trained model export job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
        .output_configuration = "outputConfiguration",
        .status = "status",
        .status_details = "statusDetails",
        .trained_model_arn = "trainedModelArn",
        .trained_model_version_identifier = "trainedModelVersionIdentifier",
        .update_time = "updateTime",
    };
};
