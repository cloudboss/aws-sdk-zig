const IngestEndpoint = @import("ingest_endpoint.zig").IngestEndpoint;

/// An HTTP Live Streaming (HLS) ingest resource configuration.
pub const HlsIngest = struct {
    /// A list of endpoints to which the source stream should be sent.
    ingest_endpoints: ?[]const IngestEndpoint = null,

    pub const json_field_names = .{
        .ingest_endpoints = "IngestEndpoints",
    };
};
