const TagFilter = @import("tag_filter.zig").TagFilter;
const KnowledgeBaseSearchType = @import("knowledge_base_search_type.zig").KnowledgeBaseSearchType;

/// The data of the configuration for a `KNOWLEDGE_BASE` type Amazon Q in
/// Connect Assistant Association.
pub const KnowledgeBaseAssociationConfigurationData = struct {
    content_tag_filter: ?TagFilter,

    /// The maximum number of results to return per page.
    max_results: ?i32,

    /// The search type to be used against the Knowledge Base for this request. The
    /// values can be `SEMANTIC` which uses vector embeddings or `HYBRID` which use
    /// vector embeddings and raw text
    override_knowledge_base_search_type: ?KnowledgeBaseSearchType,

    pub const json_field_names = .{
        .content_tag_filter = "contentTagFilter",
        .max_results = "maxResults",
        .override_knowledge_base_search_type = "overrideKnowledgeBaseSearchType",
    };
};
