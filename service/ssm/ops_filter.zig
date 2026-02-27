const OpsFilterOperatorType = @import("ops_filter_operator_type.zig").OpsFilterOperatorType;

/// A filter for viewing OpsData summaries.
pub const OpsFilter = struct {
    /// The name of the filter.
    key: []const u8,

    /// The type of filter.
    type: ?OpsFilterOperatorType,

    /// The filter value.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .type = "Type",
        .values = "Values",
    };
};
