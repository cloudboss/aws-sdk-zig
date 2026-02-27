const SrtListenerDecryptionRequest = @import("srt_listener_decryption_request.zig").SrtListenerDecryptionRequest;

/// Configuration for SRT Listener input. Encryption is REQUIRED for all SRT
/// Listener inputs for security reasons. You must provide decryption settings
/// including algorithm and passphrase secret ARN.
pub const SrtListenerSettingsRequest = struct {
    decryption: SrtListenerDecryptionRequest,

    /// Required. The preferred latency in milliseconds for packet loss and
    /// recovery. Range 120-15000.
    minimum_latency: i32,

    /// Optional. The stream ID if the upstream system uses this identifier.
    stream_id: ?[]const u8,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .minimum_latency = "MinimumLatency",
        .stream_id = "StreamId",
    };
};
