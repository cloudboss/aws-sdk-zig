/// The Amazon Chime Voice Connector settings. Includes any Amazon S3 buckets
/// designated for
/// storing call detail records.
pub const VoiceConnectorSettings = struct {
    /// The Amazon S3 bucket designated for call detail record storage.
    cdr_bucket: ?[]const u8,

    pub const json_field_names = .{
        .cdr_bucket = "CdrBucket",
    };
};
