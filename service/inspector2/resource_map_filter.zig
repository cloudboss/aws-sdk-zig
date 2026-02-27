const ResourceMapComparison = @import("resource_map_comparison.zig").ResourceMapComparison;

/// A resource map filter for a software bill of material report.
pub const ResourceMapFilter = struct {
    /// The filter's comparison.
    comparison: ResourceMapComparison,

    /// The filter's key.
    key: []const u8,

    /// The filter's value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .key = "key",
        .value = "value",
    };
};
