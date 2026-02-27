const SearchResourcesSortAttributeName = @import("search_resources_sort_attribute_name.zig").SearchResourcesSortAttributeName;
const OrderBy = @import("order_by.zig").OrderBy;

/// Specifies criteria for sorting the results of a query for information about
/// Amazon Web Services resources that Amazon Macie monitors and analyzes.
pub const SearchResourcesSortCriteria = struct {
    /// The property to sort the results by.
    attribute_name: ?SearchResourcesSortAttributeName,

    /// The sort order to apply to the results, based on the value for the property
    /// specified by the attributeName property. Valid values are: ASC, sort the
    /// results in ascending order; and, DESC, sort the results in descending order.
    order_by: ?OrderBy,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .order_by = "orderBy",
    };
};
