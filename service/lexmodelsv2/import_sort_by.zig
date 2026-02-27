const ImportSortAttribute = @import("import_sort_attribute.zig").ImportSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Provides information for sorting a list of imports.
pub const ImportSortBy = struct {
    /// The export field to use for sorting.
    attribute: ImportSortAttribute,

    /// The order to sort the list.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
