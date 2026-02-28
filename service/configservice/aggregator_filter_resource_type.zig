const AggregatorFilterType = @import("aggregator_filter_type.zig").AggregatorFilterType;

/// An object to filter the configuration recorders based on the resource types
/// in scope for recording.
pub const AggregatorFilterResourceType = struct {
    /// The type of resource type filter to apply. `INCLUDE` specifies that the list
    /// of resource types in the `Value` field will be aggregated and no other
    /// resource types will be filtered.
    type: ?AggregatorFilterType,

    /// Comma-separate list of resource types to filter your aggregated
    /// configuration recorders.
    value: ?[]const []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
