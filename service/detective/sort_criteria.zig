const Field = @import("field.zig").Field;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Details about the criteria used for sorting investigations.
pub const SortCriteria = struct {
    /// Represents the `Field` attribute to sort investigations.
    field: ?Field,

    /// The order by which the sorted findings are displayed.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .field = "Field",
        .sort_order = "SortOrder",
    };
};
