const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Filters certificates by DNS name.
pub const DnsNameFilter = struct {
    /// The comparison operator to use.
    comparison_operator: ComparisonOperator,

    /// The DNS name value to match against.
    value: []const u8,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .value = "Value",
    };
};
