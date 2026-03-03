const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

/// Specifies a subset of fields associated with tasks related to accepting an
/// engagement invitation.
pub const ListEngagementByAcceptingInvitationTaskSummary = struct {
    /// The unique identifier of the engagement invitation that was accepted.
    engagement_invitation_id: ?[]const u8 = null,

    /// Detailed message describing the failure and possible recovery steps.
    message: ?[]const u8 = null,

    /// Unique identifier of opportunity that was created.
    opportunity_id: ?[]const u8 = null,

    /// A code pointing to the specific reason for the failure.
    reason_code: ?ReasonCode = null,

    /// Unique identifier of the resource snapshot job that was created.
    resource_snapshot_job_id: ?[]const u8 = null,

    /// Task start timestamp.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the task.
    task_arn: ?[]const u8 = null,

    /// Unique identifier of the task.
    task_id: ?[]const u8 = null,

    /// Status of the task.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .engagement_invitation_id = "EngagementInvitationId",
        .message = "Message",
        .opportunity_id = "OpportunityId",
        .reason_code = "ReasonCode",
        .resource_snapshot_job_id = "ResourceSnapshotJobId",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
    };
};
