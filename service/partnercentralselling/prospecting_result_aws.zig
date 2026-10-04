const ProspectingResultCustomer = @import("prospecting_result_customer.zig").ProspectingResultCustomer;
const ProspectingInsights = @import("prospecting_insights.zig").ProspectingInsights;

/// Contains the prospecting data that AWS sources. This includes task execution
/// details, customer account information, and insights that AI generates from
/// the prospecting analysis.
pub const ProspectingResultAws = struct {
    /// Contains details about the prospected customer account, including
    /// geographic, industry, and segment classifications.
    customer: ?ProspectingResultCustomer = null,

    /// The timestamp when the prospecting task completed processing. The format is
    /// ISO 8601 (UTC).
    end_time: ?i64 = null,

    /// Insights that AI generates from the prospecting analysis. These insights
    /// include engagement scores and solution fit assessments for the prospected
    /// customer.
    insights: ?ProspectingInsights = null,

    /// The timestamp when the prospecting result context was created. The format is
    /// ISO 8601 (UTC).
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the prospecting task. Use this ARN to
    /// track and manage the task within AWS.
    task_arn: ?[]const u8 = null,

    /// The unique identifier of the prospecting task that generates this result.
    task_id: ?[]const u8 = null,

    /// The name that the user provides for the prospecting task that generates this
    /// result.
    task_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer = "Customer",
        .end_time = "EndTime",
        .insights = "Insights",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_name = "TaskName",
    };
};
