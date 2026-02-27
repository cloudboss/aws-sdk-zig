/// Configurations for when you choose fixed-size chunking. If you set the
/// `chunkingStrategy` as `NONE`, exclude this field.
pub const FixedSizeChunkingConfiguration = struct {
    /// The maximum number of tokens to include in a chunk.
    max_tokens: i32,

    /// The percentage of overlap between adjacent chunks of a data source.
    overlap_percentage: i32,

    pub const json_field_names = .{
        .max_tokens = "maxTokens",
        .overlap_percentage = "overlapPercentage",
    };
};
