const HierarchicalChunkingLevelConfiguration = @import("hierarchical_chunking_level_configuration.zig").HierarchicalChunkingLevelConfiguration;

/// Settings for hierarchical document chunking for a data source. Hierarchical
/// chunking splits documents into layers of chunks where the first layer
/// contains large chunks, and the second layer contains smaller chunks derived
/// from the first layer.
///
/// You configure the number of tokens to overlap, or repeat across adjacent
/// chunks. For example, if you set overlap tokens to 60, the last 60 tokens in
/// the first chunk are also included at the beginning of the second chunk. For
/// each layer, you must also configure the maximum number of tokens in a chunk.
pub const HierarchicalChunkingConfiguration = struct {
    /// Token settings for each layer.
    level_configurations: []const HierarchicalChunkingLevelConfiguration,

    /// The number of tokens to repeat across chunks in the same layer.
    overlap_tokens: i32,

    pub const json_field_names = .{
        .level_configurations = "levelConfigurations",
        .overlap_tokens = "overlapTokens",
    };
};
