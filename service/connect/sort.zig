const SortableFieldName = @import("sortable_field_name.zig").SortableFieldName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// A structure that defines the field name to sort by and a sort order.
pub const Sort = struct {
    /// The name of the field on which to sort.
    field_name: SortableFieldName,

    /// An ascending or descending sort.
    order: SortOrder,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .order = "Order",
    };
};
