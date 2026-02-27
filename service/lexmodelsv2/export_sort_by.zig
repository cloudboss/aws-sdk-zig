const ExportSortAttribute = @import("export_sort_attribute.zig").ExportSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Provides information about sorting a list of exports.
pub const ExportSortBy = struct {
    /// The export field to use for sorting.
    attribute: ExportSortAttribute,

    /// The order to sort the list.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
