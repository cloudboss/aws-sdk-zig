const ServiceCollection = @import("service_collection.zig").ServiceCollection;

/// Specifies one or more service names that are used to list anomalies.
pub const ListAnomaliesForInsightFilters = struct {
    service_collection: ?ServiceCollection = null,

    pub const json_field_names = .{
        .service_collection = "ServiceCollection",
    };
};
