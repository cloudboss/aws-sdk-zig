const SlotFilterName = @import("slot_filter_name.zig").SlotFilterName;
const SlotFilterOperator = @import("slot_filter_operator.zig").SlotFilterOperator;

/// Filters the response from the `ListSlots`
/// operation.
pub const SlotFilter = struct {
    /// The name of the field to use for filtering.
    name: SlotFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListSlots` operation should return only aliases that
    /// equal the specified value. Specify `CO` when the
    /// `ListSlots` operation should return aliases that contain
    /// the specified value.
    operator: SlotFilterOperator,

    /// The value to use to filter the response.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
