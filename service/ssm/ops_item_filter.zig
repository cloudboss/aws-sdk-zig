const OpsItemFilterKey = @import("ops_item_filter_key.zig").OpsItemFilterKey;
const OpsItemFilterOperator = @import("ops_item_filter_operator.zig").OpsItemFilterOperator;

/// Describes an OpsItem filter.
pub const OpsItemFilter = struct {
    /// The name of the filter.
    key: OpsItemFilterKey,

    /// The operator used by the filter call.
    operator: OpsItemFilterOperator,

    /// The filter value.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .operator = "Operator",
        .values = "Values",
    };
};
