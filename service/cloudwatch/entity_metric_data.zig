const Entity = @import("entity.zig").Entity;
const MetricDatum = @import("metric_datum.zig").MetricDatum;

/// A set of metrics that are associated with an entity, such as a specific
/// service
/// or resource. Contains the entity and the list of metric data associated with
/// it.
pub const EntityMetricData = struct {
    /// The entity associated with the metrics.
    entity: ?Entity,

    /// The metric data.
    metric_data: ?[]const MetricDatum,

    pub const json_field_names = .{
        .entity = "Entity",
        .metric_data = "MetricData",
    };
};
