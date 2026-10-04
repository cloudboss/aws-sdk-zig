const ConnectorTypeComparison = @import("connector_type_comparison.zig").ConnectorTypeComparison;
const ConnectorType = @import("connector_type.zig").ConnectorType;

/// A filter that matches connectors by connector type.
pub const ConnectorTypeFilter = struct {
    /// The comparison operator for the connector type filter.
    comparison: ConnectorTypeComparison,

    /// The connector type value to filter by.
    value: ConnectorType,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
