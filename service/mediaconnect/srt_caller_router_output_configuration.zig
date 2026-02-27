const SrtEncryptionConfiguration = @import("srt_encryption_configuration.zig").SrtEncryptionConfiguration;

/// The configuration settings for a router output using the SRT (Secure
/// Reliable Transport) protocol in caller mode, including the destination
/// address and port, minimum latency, stream ID, and encryption key
/// configuration.
pub const SrtCallerRouterOutputConfiguration = struct {
    /// The destination IP address for the SRT protocol in caller mode.
    destination_address: []const u8,

    /// The destination port number for the SRT protocol in caller mode.
    destination_port: i32,

    /// Defines the encryption settings for an SRT caller output, including the
    /// encryption key configuration and associated parameters.
    encryption_configuration: ?SrtEncryptionConfiguration,

    /// The minimum latency in milliseconds for the SRT protocol in caller mode.
    minimum_latency_milliseconds: i64,

    /// The stream ID for the SRT protocol in caller mode.
    stream_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
        .encryption_configuration = "EncryptionConfiguration",
        .minimum_latency_milliseconds = "MinimumLatencyMilliseconds",
        .stream_id = "StreamId",
    };
};
