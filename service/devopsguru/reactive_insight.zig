const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Information about a reactive insight. This object is returned by
/// `ListInsights`.
pub const ReactiveInsight = struct {
    /// Describes the reactive insight.
    description: ?[]const u8 = null,

    /// The ID of a reactive insight.
    id: ?[]const u8 = null,

    insight_time_range: ?InsightTimeRange = null,

    /// The name of a reactive insight.
    name: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    /// The severity of the insight. For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?InsightSeverity = null,

    /// The ID of the Amazon Web Services System Manager OpsItem created for this
    /// insight. You must enable
    /// the creation of OpstItems insights before they are created for each insight.
    ssm_ops_item_id: ?[]const u8 = null,

    /// The status of a reactive insight.
    status: ?InsightStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .resource_collection = "ResourceCollection",
        .severity = "Severity",
        .ssm_ops_item_id = "SsmOpsItemId",
        .status = "Status",
    };
};
