const ConnectionMode = @import("connection_mode.zig").ConnectionMode;

/// Placeholder documentation for SrtOutputDestinationSettings
pub const SrtOutputDestinationSettings = struct {
    /// Specifies the mode the output should use for connection establishment.
    /// CALLER mode requires URL, LISTENER mode requires port.
    connection_mode: ?ConnectionMode,

    /// Arn used to extract the password from Secrets Manager
    encryption_passphrase_secret_arn: ?[]const u8,

    /// Port number for listener mode connections (required when connectionMode is
    /// LISTENER, must not be provided when connectionMode is CALLER).
    listener_port: ?i32,

    /// Stream id for SRT destinations (URLs of type srt://)
    stream_id: ?[]const u8,

    /// A URL specifying a destination
    url: ?[]const u8,

    pub const json_field_names = .{
        .connection_mode = "ConnectionMode",
        .encryption_passphrase_secret_arn = "EncryptionPassphraseSecretArn",
        .listener_port = "ListenerPort",
        .stream_id = "StreamId",
        .url = "Url",
    };
};
