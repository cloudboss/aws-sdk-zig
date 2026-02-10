const CapacityManagerDimension = @import("capacity_manager_dimension.zig").CapacityManagerDimension;
const MetricValue = @import("metric_value.zig").MetricValue;

/// Contains a single data point from a capacity metrics query, including the
/// dimension values, timestamp, and metric values for that specific
/// combination.
pub const MetricDataResult = struct {
    /// The dimension values that identify this specific data point, such as account
    /// ID, region, and instance family.
    dimension: ?CapacityManagerDimension,

    /// The metric values and statistics for this data point, containing the actual
    /// capacity usage numbers.
    metric_values: ?[]const MetricValue,

    /// The timestamp for this data point, indicating when the capacity usage
    /// occurred.
    timestamp: ?i64,
};
