const ResourceStringComparison = @import("resource_string_comparison.zig").ResourceStringComparison;

/// A resource string filter for a software bill of materials report.
pub const ResourceStringFilter = struct {
    /// The filter's comparison.
    comparison: ResourceStringComparison,

    /// The filter's value.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
