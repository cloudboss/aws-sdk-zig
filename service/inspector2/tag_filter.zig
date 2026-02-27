const TagComparison = @import("tag_comparison.zig").TagComparison;

/// The tag filter.
pub const TagFilter = struct {
    /// The tag filter comparison value.
    comparison: TagComparison,

    /// The tag filter key.
    key: []const u8,

    /// The tag filter value.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .key = "key",
        .value = "value",
    };
};
