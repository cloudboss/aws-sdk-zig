const KnowledgeBaseSearchFilterName = @import("knowledge_base_search_filter_name.zig").KnowledgeBaseSearchFilterName;
const KnowledgeBaseSearchOperator = @import("knowledge_base_search_operator.zig").KnowledgeBaseSearchOperator;

/// A filter to apply when searching knowledge bases.
pub const KnowledgeBaseSearchFilter = struct {
    /// The name of the field to filter on.
    name: KnowledgeBaseSearchFilterName,

    /// The comparison operator to use for the filter.
    operator: KnowledgeBaseSearchOperator,

    /// The value to filter on.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .value = "value",
    };
};
