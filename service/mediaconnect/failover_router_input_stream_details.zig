const FailoverRouterInputIndexedStreamDetails = @import("failover_router_input_indexed_stream_details.zig").FailoverRouterInputIndexedStreamDetails;

/// Configuration details for a failover router input that can automatically
/// switch between two sources.
pub const FailoverRouterInputStreamDetails = struct {
    /// Configuration details for the secondary source (index 1) in the failover
    /// setup.
    source_index_one_stream_details: FailoverRouterInputIndexedStreamDetails,

    /// Configuration details for the primary source (index 0) in the failover
    /// setup.
    source_index_zero_stream_details: FailoverRouterInputIndexedStreamDetails,

    pub const json_field_names = .{
        .source_index_one_stream_details = "SourceIndexOneStreamDetails",
        .source_index_zero_stream_details = "SourceIndexZeroStreamDetails",
    };
};
