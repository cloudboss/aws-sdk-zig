const SlotTypeFilterName = @import("slot_type_filter_name.zig").SlotTypeFilterName;
const SlotTypeFilterOperator = @import("slot_type_filter_operator.zig").SlotTypeFilterOperator;

/// Filters the response from the `ListSlotTypes`
/// operation.
pub const SlotTypeFilter = struct {
    /// The name of the field to use for filtering.
    name: SlotTypeFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListSlotTypes` operation should return only aliases that
    /// equal the specified value. Specify `CO` when the
    /// `ListSlotTypes` operation should return aliases that
    /// contain the specified value.
    operator: SlotTypeFilterOperator,

    /// The value to use to filter the response.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
