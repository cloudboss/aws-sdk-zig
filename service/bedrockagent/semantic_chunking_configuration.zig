/// Settings for semantic document chunking for a data source. Semantic chunking
/// splits a document into into smaller documents based on groups of similar
/// content derived from the text with natural language processing.
///
/// With semantic chunking, each sentence is compared to the next to determine
/// how similar they are. You specify a threshold in the form of a percentile,
/// where adjacent sentences that are less similar than that percentage of
/// sentence pairs are divided into separate chunks. For example, if you set the
/// threshold to 90, then the 10 percent of sentence pairs that are least
/// similar are split. So if you have 101 sentences, 100 sentence pairs are
/// compared, and the 10 with the least similarity are split, creating 11
/// chunks. These chunks are further split if they exceed the max token size.
///
/// You must also specify a buffer size, which determines whether sentences are
/// compared in isolation, or within a moving context window that includes the
/// previous and following sentence. For example, if you set the buffer size to
/// `1`, the embedding for sentence 10 is derived from sentences 9, 10, and 11
/// combined.
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
