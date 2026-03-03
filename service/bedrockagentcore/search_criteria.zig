const MemoryMetadataFilterExpression = @import("memory_metadata_filter_expression.zig").MemoryMetadataFilterExpression;

/// Contains search criteria for retrieving memory records.
pub const SearchCriteria = struct {
    /// The memory strategy identifier to filter memory records by.
    memory_strategy_id: ?[]const u8 = null,

    /// Filters to apply to metadata associated with a memory.
    metadata_filters: ?[]const MemoryMetadataFilterExpression = null,

    /// The search query to use for finding relevant memory records.
    search_query: []const u8,

    /// The maximum number of top-scoring memory records to return. This value is
    /// used for semantic search ranking.
    top_k: i32 = 10,

    pub const json_field_names = .{
        .memory_strategy_id = "memoryStrategyId",
        .metadata_filters = "metadataFilters",
        .search_query = "searchQuery",
        .top_k = "topK",
    };
};
