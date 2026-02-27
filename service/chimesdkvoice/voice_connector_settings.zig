/// The Amazon Chime SDK Voice Connector settings. Includes any Amazon
/// S3 buckets designated for storing call detail records.
pub const VoiceConnectorSettings = struct {
    /// The S3 bucket that stores the Voice Connector's call detail records.
    cdr_bucket: ?[]const u8,

    pub const json_field_names = .{
        .cdr_bucket = "CdrBucket",
    };
};
