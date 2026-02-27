const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Filters you can use to specify which events are returned when `ListEvents`
/// is called.
pub const SearchOrganizationInsightsFilters = struct {
    resource_collection: ?ResourceCollection,

    service_collection: ?ServiceCollection,

    /// An array of severity values used to search for insights.
    severities: ?[]const InsightSeverity,

    /// An array of status values used to search for insights.
    statuses: ?[]const InsightStatus,

    pub const json_field_names = .{
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severities = "Severities",
        .statuses = "Statuses",
    };
};
