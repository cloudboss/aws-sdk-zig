/// Configuration for memory retrieval within a namespace.
pub const HarnessAgentCoreMemoryRetrievalConfig = struct {
    /// The minimum relevance score for retrieved memories.
    relevance_score: ?f32 = null,

    /// The ID of the retrieval strategy to use.
    strategy_id: ?[]const u8 = null,

    /// The maximum number of memory entries to retrieve.
    top_k: ?i32 = null,

    pub const json_field_names = .{
        .relevance_score = "relevanceScore",
        .strategy_id = "strategyId",
        .top_k = "topK",
    };
};
