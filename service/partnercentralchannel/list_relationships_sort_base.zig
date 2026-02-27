const ListRelationshipsSortName = @import("list_relationships_sort_name.zig").ListRelationshipsSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Base sorting configuration for relationships.
pub const ListRelationshipsSortBase = struct {
    /// The field to sort by.
    sort_by: ListRelationshipsSortName,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
