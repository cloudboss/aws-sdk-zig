const CisStringComparison = @import("cis_string_comparison.zig").CisStringComparison;

/// The CIS string filter.
pub const CisStringFilter = struct {
    /// The comparison value of the CIS string filter.
    comparison: CisStringComparison,

    /// The value of the CIS string filter.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
