const InvestigationSortField = @import("investigation_sort_field.zig").InvestigationSortField;
const OrderBy = @import("order_by.zig").OrderBy;

/// Contains information about the criteria used for sorting investigations.
pub const InvestigationSortCriteria = struct {
    /// The attribute by which to sort investigations.
    attribute_name: ?InvestigationSortField = null,

    /// The order in which the sorted results are to be displayed.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .order_by = "OrderBy",
    };
};
