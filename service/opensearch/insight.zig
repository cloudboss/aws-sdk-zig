const InsightPriorityLevel = @import("insight_priority_level.zig").InsightPriorityLevel;
const InsightStatus = @import("insight_status.zig").InsightStatus;
const InsightType = @import("insight_type.zig").InsightType;

/// Represents an insight returned by the `ListInsights` operation. An insight
/// is a notification about a domain event or recommendation that helps you
/// optimize your
/// Amazon OpenSearch Service domain.
pub const Insight = struct {
    /// The timestamp when the insight was created, in epoch milliseconds.
    creation_time: ?i64 = null,

    /// The display name of the insight.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the insight.
    insight_id: ?[]const u8 = null,

    /// Indicates whether the insight is experimental.
    is_experimental: ?bool = null,

    /// The priority level of the insight. Possible values are `CRITICAL`,
    /// `HIGH`, `MEDIUM`, and `LOW`.
    priority: ?InsightPriorityLevel = null,

    /// The current status of the insight. Possible values are `ACTIVE`,
    /// `RESOLVED`, and `DISMISSED`.
    status: ?InsightStatus = null,

    /// The type of the insight. Possible values are `EVENT` and
    /// `RECOMMENDATION`.
    @"type": ?InsightType = null,

    /// The timestamp when the insight was last updated, in epoch milliseconds.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .insight_id = "InsightId",
        .is_experimental = "IsExperimental",
        .priority = "Priority",
        .status = "Status",
        .@"type" = "Type",
        .update_time = "UpdateTime",
    };
};
