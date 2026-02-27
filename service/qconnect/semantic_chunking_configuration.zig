/// Settings for semantic document chunking for a data source. Semantic chunking
/// splits a document into smaller documents based on groups of similar content
/// derived from the text with natural language processing.
pub const SemanticChunkingConfiguration = struct {
    /// The dissimilarity threshold for splitting chunks.
    breakpoint_percentile_threshold: i32,

    /// The buffer size.
    buffer_size: i32,

    /// The maximum number of tokens that a chunk can contain.
    max_tokens: i32,

    pub const json_field_names = .{
        .breakpoint_percentile_threshold = "breakpointPercentileThreshold",
        .buffer_size = "bufferSize",
        .max_tokens = "maxTokens",
    };
};
