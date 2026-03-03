const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Information about a reactive insight. This object is returned by
/// `DescribeInsight.`
pub const ReactiveInsightSummary = struct {
    /// The Amazon Resource Names (ARNs)
    /// of the Amazon Web Services resources that generated this insight.
    associated_resource_arns: ?[]const []const u8 = null,

    /// The ID of a reactive summary.
    id: ?[]const u8 = null,

    insight_time_range: ?InsightTimeRange = null,

    /// The name of a reactive insight.
    name: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    /// A collection of the names of Amazon Web Services services.
    service_collection: ?ServiceCollection = null,

    /// The severity of the insight. For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?InsightSeverity = null,

    /// The status of a reactive insight.
    status: ?InsightStatus = null,

    pub const json_field_names = .{
        .associated_resource_arns = "AssociatedResourceArns",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severity = "Severity",
        .status = "Status",
    };
};
