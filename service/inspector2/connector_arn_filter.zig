const ConnectorArnComparison = @import("connector_arn_comparison.zig").ConnectorArnComparison;

/// A filter that matches connectors by connector ARN.
pub const ConnectorArnFilter = struct {
    /// The comparison operator for the connector ARN filter.
    comparison: ConnectorArnComparison,

    /// The connector ARN value to filter by.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
