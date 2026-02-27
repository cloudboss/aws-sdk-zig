const IntentFilterName = @import("intent_filter_name.zig").IntentFilterName;
const IntentFilterOperator = @import("intent_filter_operator.zig").IntentFilterOperator;

/// Filters the response from the `ListIntents`
/// operation.
pub const IntentFilter = struct {
    /// The name of the field to use for the filter.
    name: IntentFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListIntents` operation should return only aliases that
    /// equal the specified value. Specify `CO` when the
    /// `ListIntents` operation should return aliases that
    /// contain the specified value.
    operator: IntentFilterOperator,

    /// The value to use for the filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
