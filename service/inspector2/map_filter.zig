const MapComparison = @import("map_comparison.zig").MapComparison;

/// An object that describes details of a map filter.
pub const MapFilter = struct {
    /// The operator to use when comparing values in the filter.
    comparison: MapComparison,

    /// The tag key used in the filter.
    key: []const u8,

    /// The tag value used in the filter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison = "comparison",
        .key = "key",
        .value = "value",
    };
};
