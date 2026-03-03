const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ServiceCollection = @import("service_collection.zig").ServiceCollection;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Specifies values used to filter responses when searching for insights.
/// You can use a `ResourceCollection`, `ServiceCollection`, array of
/// severities, and an array of status values.
/// Each filter type contains one or more values to search for. If you specify
/// multiple filter types,
/// the filter types are joined with an `AND`, and the request returns only
/// results that match all of the specified filters.
pub const SearchInsightsFilters = struct {
    resource_collection: ?ResourceCollection = null,

    /// A collection of the names of Amazon Web Services services.
    service_collection: ?ServiceCollection = null,

    /// An array of severity values used to search for insights.
    severities: ?[]const InsightSeverity = null,

    /// An array of status values used to search for insights.
    statuses: ?[]const InsightStatus = null,

    pub const json_field_names = .{
        .resource_collection = "ResourceCollection",
        .service_collection = "ServiceCollection",
        .severities = "Severities",
        .statuses = "Statuses",
    };
};
