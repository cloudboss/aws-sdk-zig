const aws = @import("aws");

/// The Amazon S3 logging configuration for a session.
pub const SessionS3LoggingConfiguration = struct {
    /// Whether Amazon S3 logging is enabled for the session.
    enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt logs published
    /// to Amazon S3.
    encryption_key_arn: ?[]const u8 = null,

    /// A map of log component names (for example, `SPARK_DRIVER`, `SPARK_EXECUTOR`)
    /// to the list of log types to publish for that component (for example,
    /// `stdout`, `stderr`).
    log_types: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The Amazon S3 destination URI where session logs are published.
    log_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_key_arn = "EncryptionKeyArn",
        .log_types = "LogTypes",
        .log_uri = "LogUri",
    };
};
