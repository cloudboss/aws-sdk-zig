const SrtDecryptionConfiguration = @import("srt_decryption_configuration.zig").SrtDecryptionConfiguration;

/// The configuration settings for a router input using the SRT (Secure Reliable
/// Transport) protocol in listener mode, including the port, minimum latency,
/// and decryption key configuration.
pub const SrtListenerRouterInputConfiguration = struct {
    /// Specifies the decryption settings for an SRT listener input, including the
    /// encryption key configuration and associated parameters.
    decryption_configuration: ?SrtDecryptionConfiguration,

    /// The minimum latency in milliseconds for the SRT protocol in listener mode.
    minimum_latency_milliseconds: i64,

    /// The port number for the SRT protocol in listener mode.
    port: i32,

    pub const json_field_names = .{
        .decryption_configuration = "DecryptionConfiguration",
        .minimum_latency_milliseconds = "MinimumLatencyMilliseconds",
        .port = "Port",
    };
};
