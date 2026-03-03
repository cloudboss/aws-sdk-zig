const SrtDecryptionConfiguration = @import("srt_decryption_configuration.zig").SrtDecryptionConfiguration;

/// The configuration settings for a router input using the SRT (Secure Reliable
/// Transport) protocol in caller mode, including the source address and port,
/// minimum latency, stream ID, and decryption key configuration.
pub const SrtCallerRouterInputConfiguration = struct {
    /// Specifies the decryption settings for an SRT caller input, including the
    /// encryption key configuration and associated parameters.
    decryption_configuration: ?SrtDecryptionConfiguration = null,

    /// The minimum latency in milliseconds for the SRT protocol in caller mode.
    minimum_latency_milliseconds: i64,

    /// The source IP address for the SRT protocol in caller mode.
    source_address: []const u8,

    /// The source port number for the SRT protocol in caller mode.
    source_port: i32,

    /// The stream ID for the SRT protocol in caller mode.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption_configuration = "DecryptionConfiguration",
        .minimum_latency_milliseconds = "MinimumLatencyMilliseconds",
        .source_address = "SourceAddress",
        .source_port = "SourcePort",
        .stream_id = "StreamId",
    };
};
