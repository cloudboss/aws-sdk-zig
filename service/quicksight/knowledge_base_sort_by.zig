const KnowledgeBaseSortByField = @import("knowledge_base_sort_by_field.zig").KnowledgeBaseSortByField;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The sort configuration for searching knowledge bases.
pub const KnowledgeBaseSortBy = struct {
    /// The field to sort by.
    sort_by_field: KnowledgeBaseSortByField,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by_field = "sortByField",
        .sort_order = "sortOrder",
    };
};
