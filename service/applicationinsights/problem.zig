const aws = @import("aws");

const FeedbackValue = @import("feedback_value.zig").FeedbackValue;
const ResolutionMethod = @import("resolution_method.zig").ResolutionMethod;
const SeverityLevel = @import("severity_level.zig").SeverityLevel;
const Status = @import("status.zig").Status;
const Visibility = @import("visibility.zig").Visibility;

/// Describes a problem that is detected by correlating observations.
pub const Problem = struct {
    /// The Amazon Web Services account ID for the owner of the resource group
    /// affected by the problem.
    account_id: ?[]const u8 = null,

    /// The resource affected by the problem.
    affected_resource: ?[]const u8 = null,

    /// The time when the problem ended, in epoch seconds.
    end_time: ?i64 = null,

    /// Feedback provided by the user about the problem.
    feedback: ?[]const aws.map.MapEntry(FeedbackValue) = null,

    /// The ID of the problem.
    id: ?[]const u8 = null,

    /// A detailed analysis of the problem using machine learning.
    insights: ?[]const u8 = null,

    /// The last time that the problem reoccurred after its last resolution.
    last_recurrence_time: ?i64 = null,

    /// The number of times that the same problem reoccurred after the first time it
    /// was
    /// resolved.
    recurring_count: ?i64 = null,

    /// Specifies how the problem was resolved. If the value is `AUTOMATIC`, the
    /// system resolved the problem. If the value is `MANUAL`, the user resolved the
    /// problem. If the value is `UNRESOLVED`, then the problem is not resolved.
    resolution_method: ?ResolutionMethod = null,

    /// The name of the resource group affected by the problem.
    resource_group_name: ?[]const u8 = null,

    /// A measure of the level of impact of the problem.
    severity_level: ?SeverityLevel = null,

    /// The short name of the problem associated with the SNS notification.
    short_name: ?[]const u8 = null,

    /// The time when the problem started, in epoch seconds.
    start_time: ?i64 = null,

    /// The status of the problem.
    status: ?Status = null,

    /// The name of the problem.
    title: ?[]const u8 = null,

    /// Specifies whether or not you can view the problem. Updates to ignored
    /// problems do not
    /// generate notifications.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .affected_resource = "AffectedResource",
        .end_time = "EndTime",
        .feedback = "Feedback",
        .id = "Id",
        .insights = "Insights",
        .last_recurrence_time = "LastRecurrenceTime",
        .recurring_count = "RecurringCount",
        .resolution_method = "ResolutionMethod",
        .resource_group_name = "ResourceGroupName",
        .severity_level = "SeverityLevel",
        .short_name = "ShortName",
        .start_time = "StartTime",
        .status = "Status",
        .title = "Title",
        .visibility = "Visibility",
    };
};
