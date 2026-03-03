const DimensionCondition = @import("dimension_condition.zig").DimensionCondition;

/// Represents a filter condition for Capacity Manager queries. Contains
/// dimension-based filtering criteria used to narrow down metric data and
/// dimension results.
pub const CapacityManagerCondition = struct {
    /// The dimension-based condition that specifies how to filter the data based on
    /// dimension values.
    dimension_condition: ?DimensionCondition = null,
};
