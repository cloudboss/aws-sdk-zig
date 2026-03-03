const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const PredictionTimeRange = @import("prediction_time_range.zig").PredictionTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Details about a proactive insight. This object is returned by
/// `ListInsights`.
pub const ProactiveInsight = struct {
    /// Describes the proactive insight.
    description: ?[]const u8 = null,

    /// The ID of the proactive insight.
    id: ?[]const u8 = null,

    insight_time_range: ?InsightTimeRange = null,

    /// The name of the proactive insight.
    name: ?[]const u8 = null,

    prediction_time_range: ?PredictionTimeRange = null,

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

    /// The status of the proactive insight.
    status: ?InsightStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .prediction_time_range = "PredictionTimeRange",
        .resource_collection = "ResourceCollection",
        .severity = "Severity",
        .ssm_ops_item_id = "SsmOpsItemId",
        .status = "Status",
    };
};
