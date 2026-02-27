const CoverageStringComparison = @import("coverage_string_comparison.zig").CoverageStringComparison;

/// Contains details of a coverage string filter.
pub const CoverageStringFilter = struct {
    /// The operator to compare strings on.
    comparison: CoverageStringComparison,

    /// The value to compare strings on.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
