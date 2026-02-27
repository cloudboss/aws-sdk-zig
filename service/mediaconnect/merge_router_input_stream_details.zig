const MergeRouterInputIndexedStreamDetails = @import("merge_router_input_indexed_stream_details.zig").MergeRouterInputIndexedStreamDetails;

/// Configuration details for a merge router input that combines two input
/// sources.
pub const MergeRouterInputStreamDetails = struct {
    /// Configuration details for the second source (index 1) in the merge setup.
    source_index_one_stream_details: MergeRouterInputIndexedStreamDetails,

    /// Configuration details for the first source (index 0) in the merge setup.
    source_index_zero_stream_details: MergeRouterInputIndexedStreamDetails,

    pub const json_field_names = .{
        .source_index_one_stream_details = "SourceIndexOneStreamDetails",
        .source_index_zero_stream_details = "SourceIndexZeroStreamDetails",
    };
};
