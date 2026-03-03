const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

/// Provides a summary of a task related to creating an opportunity from an
/// engagement. This structure contains key information about the task's status,
/// associated identifiers, and any failure details for opportunity creation
/// processes.
pub const ListOpportunityFromEngagementTaskSummary = struct {
    /// The unique identifier of the engagement context associated with the
    /// opportunity creation task. This links the task to specific contextual
    /// information within the engagement.
    context_id: ?[]const u8 = null,

    /// The unique identifier of the engagement from which the opportunity is being
    /// created. This field helps track the source of the opportunity creation task.
    engagement_id: ?[]const u8 = null,

    /// A detailed message providing additional information about the task,
    /// especially useful in case of failures. This field may contain error details
    /// or other relevant information about the task's execution.
    message: ?[]const u8 = null,

    /// The unique identifier of the opportunity created as a result of the task.
    /// This field is populated when the task is completed successfully.
    opportunity_id: ?[]const u8 = null,

    /// A code indicating the specific reason for a task failure. This field is
    /// populated when the task status is FAILED and provides a categorized reason
    /// for the failure.
    reason_code: ?ReasonCode = null,

    /// The identifier of the resource snapshot job associated with this task, if a
    /// snapshot was created as part of the opportunity creation process.
    resource_snapshot_job_id: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated, in RFC 3339 format.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the task within AWS.
    /// This ARN can be used for referencing the task in other AWS services or APIs.
    task_arn: ?[]const u8 = null,

    /// The unique identifier of the task for creating an opportunity from an
    /// engagement.
    task_id: ?[]const u8 = null,

    /// The current status of the task. Valid values are COMPLETE, INPROGRESS, or
    /// FAILED.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .engagement_id = "EngagementId",
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
