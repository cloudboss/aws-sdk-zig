const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

/// Provides a summary of a task related to creating an engagement from an
/// opportunity. This structure contains key information about the task's
/// status, associated identifiers, and any failure details.
pub const ListEngagementFromOpportunityTaskSummary = struct {
    /// The unique identifier of the engagement created as a result of the task.
    /// This field is populated when the task is completed successfully.
    engagement_id: ?[]const u8 = null,

    /// The unique identifier of the Engagement Invitation.
    engagement_invitation_id: ?[]const u8 = null,

    /// A detailed message providing additional information about the task,
    /// especially useful in case of failures. This field may contain error details
    /// or other relevant information about the task's execution
    message: ?[]const u8 = null,

    /// The unique identifier of the original Opportunity from which the Engagement
    /// is being created. This field helps track the source of the Engagement
    /// creation task.
    opportunity_id: ?[]const u8 = null,

    /// A code indicating the specific reason for a task failure. This field is
    /// populated when the task status is FAILED and provides a categorized reason
    /// for the failure.
    reason_code: ?ReasonCode = null,

    /// The identifier of the resource snapshot job associated with this task, if a
    /// snapshot was created as part of the Engagement creation process.
    resource_snapshot_job_id: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated, in RFC 3339 5.6
    /// date-time format.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) uniquely identifying this task within AWS.
    /// This ARN can be used for referencing the task in other AWS services or APIs.
    task_arn: ?[]const u8 = null,

    /// A unique identifier for a specific task.
    task_id: ?[]const u8 = null,

    /// The current status of the task.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .engagement_id = "EngagementId",
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
