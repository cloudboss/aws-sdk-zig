const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const PredictionTimeRange = @import("prediction_time_range.zig").PredictionTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Details about a proactive insight. This object is returned by
/// `DescribeInsight`.
pub const ProactiveOrganizationInsightSummary = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8,

    /// The ID of the insight summary.
    id: ?[]const u8,

    insight_time_range: ?InsightTimeRange,

    /// The name of the insight summary.
    name: ?[]const u8,

    /// The ID of the organizational unit.
    organizational_unit_id: ?[]const u8,

    prediction_time_range: ?PredictionTimeRange,

    resource_collection: ?ResourceCollection,

    service_collection: ?ServiceCollection,

    /// An array of severity values used to search for insights.
    /// For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?InsightSeverity,

    /// An array of status values used to search for insights.
    status: ?InsightStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .organizational_unit_id = "OrganizationalUnitId",
        .prediction_time_range = "PredictionTimeRange",
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severity = "Severity",
        .status = "Status",
    };
};
