/// A summary of a single prospecting task, returned by
/// `ListProspectingFromEngagementTasks`. Contains key metrics and status
/// information without the full per-engagement detail available from
/// `GetProspectingFromEngagementTask`.
pub const ProspectingTaskSummary = struct {
    /// The number of engagements that have been successfully converted into
    /// prospecting leads.
    completed_engagement_count: i32,

    /// The timestamp indicating when the task finished processing. This field is
    /// absent if the task is still in progress. The format follows ISO 8601
    /// date-time notation.
    end_time: ?i64 = null,

    /// The number of engagements that failed to be converted. Retrieve the full
    /// task details using `GetProspectingFromEngagementTask` for per-engagement
    /// error information.
    failed_engagement_count: i32,

    /// The timestamp indicating when the task was initiated. The format follows ISO
    /// 8601 date-time notation.
    start_time: i64,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: []const u8,

    /// The unique identifier of the task. Use this value with
    /// `GetProspectingFromEngagementTask` to retrieve full task details.
    task_id: []const u8,

    /// The descriptive name of the task provided when it was created.
    task_name: []const u8,

    /// The total number of engagements included in the task.
    total_engagement_count: i32 = 0,

    pub const json_field_names = .{
        .completed_engagement_count = "CompletedEngagementCount",
        .end_time = "EndTime",
        .failed_engagement_count = "FailedEngagementCount",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_name = "TaskName",
        .total_engagement_count = "TotalEngagementCount",
    };
};
