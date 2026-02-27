const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

/// Configuration information of a Kinesis video stream.
pub const KinesisVideoStreamConfig = struct {
    /// The encryption configuration.
    encryption_config: EncryptionConfig,

    /// The prefix of the video stream.
    prefix: []const u8,

    /// The number of hours data is retained in the stream. Kinesis Video Streams
    /// retains the data in a data store that
    /// is associated with the stream.
    ///
    /// The default value is 0, indicating that the stream does not persist data.
    retention_period_hours: i32 = 0,

    pub const json_field_names = .{
        .encryption_config = "EncryptionConfig",
        .prefix = "Prefix",
        .retention_period_hours = "RetentionPeriodHours",
    };
};
