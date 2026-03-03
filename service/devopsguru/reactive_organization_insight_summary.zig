const InsightTimeRange = @import("insight_time_range.zig").InsightTimeRange;
const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Information about a reactive insight. This object is returned by
/// `DescribeInsight`.
pub const ReactiveOrganizationInsightSummary = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The ID of the insight summary.
    id: ?[]const u8 = null,

    insight_time_range: ?InsightTimeRange = null,

    /// The name of the insight summary.
    name: ?[]const u8 = null,

    /// The ID of the organizational unit.
    organizational_unit_id: ?[]const u8 = null,

    resource_collection: ?ResourceCollection = null,

    service_collection: ?ServiceCollection = null,

    /// An array of severity values used to search for insights.
    /// For more information, see
    /// [Understanding
    /// insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities) in the *Amazon DevOps Guru User Guide*.
    severity: ?InsightSeverity = null,

    /// An array of status values used to search for insights.
    status: ?InsightStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .id = "Id",
        .insight_time_range = "InsightTimeRange",
        .name = "Name",
        .organizational_unit_id = "OrganizationalUnitId",
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severity = "Severity",
        .status = "Status",
    };
};
