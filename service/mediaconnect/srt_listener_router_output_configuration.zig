const SrtEncryptionConfiguration = @import("srt_encryption_configuration.zig").SrtEncryptionConfiguration;

/// The configuration settings for a router output using the SRT (Secure
/// Reliable Transport) protocol in listener mode, including the port, minimum
/// latency, and encryption key configuration.
pub const SrtListenerRouterOutputConfiguration = struct {
    /// Defines the encryption settings for an SRT listener output, including the
    /// encryption key configuration and associated parameters.
    encryption_configuration: ?SrtEncryptionConfiguration,

    /// The minimum latency in milliseconds for the SRT protocol in listener mode.
    minimum_latency_milliseconds: i64,

    /// The port number for the SRT protocol in listener mode.
    port: i32,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
        .minimum_latency_milliseconds = "MinimumLatencyMilliseconds",
        .port = "Port",
    };
};
