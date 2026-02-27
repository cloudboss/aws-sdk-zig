/// Token settings for a layer in a hierarchical chunking configuration.
pub const HierarchicalChunkingLevelConfiguration = struct {
    /// The maximum number of tokens that a chunk can contain in this layer.
    max_tokens: i32,

    pub const json_field_names = .{
        .max_tokens = "maxTokens",
    };
};
