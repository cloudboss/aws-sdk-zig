const CoverageMapComparison = @import("coverage_map_comparison.zig").CoverageMapComparison;

/// Contains details of a coverage map filter.
pub const CoverageMapFilter = struct {
    /// The operator to compare coverage on.
    comparison: CoverageMapComparison,

    /// The tag key associated with the coverage map filter.
    key: []const u8,

    /// The tag value associated with the coverage map filter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison = "comparison",
        .key = "key",
        .value = "value",
    };
};
