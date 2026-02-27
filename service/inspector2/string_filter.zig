const StringComparison = @import("string_comparison.zig").StringComparison;

/// An object that describes the details of a string filter.
pub const StringFilter = struct {
    /// The operator to use when comparing values in the filter.
    comparison: StringComparison,

    /// The value to filter on.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
