const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const PredictionTimeRange = @import("prediction_time_range.zig").PredictionTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Details about a proactive insight. This object is returned by
/// `DescribeInsight.`
pub const ProactiveInsightSummary = struct {
    /// The Amazon Resource Names (ARNs)
    /// of the Amazon Web Services resources that generated this insight.
    associated_resource_arns: ?[]const []const u8 = null,

    /// The ID of the proactive insight.
    id: ?[]const u8 = null,

    insight_time_range: ?InsightTimeRange = null,

    /// The name of the proactive insight.
    name: ?[]const u8 = null,

    prediction_time_range: ?PredictionTimeRange = null,

    resource_collection: ?ResourceCollection = null,

    /// A collection of the names of Amazon Web Services services.
    service_collection: ?ServiceCollection = null,

    /// The severity of the insight. For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?InsightSeverity = null,

    /// The status of the proactive insight.
    status: ?InsightStatus = null,

    pub const json_field_names = .{
        .associated_resource_arns = "AssociatedResourceArns",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .prediction_time_range = "PredictionTimeRange",
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severity = "Severity",
        .status = "Status",
    };
};
