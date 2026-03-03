/// The Amazon Chime Business Calling settings for the administrator's AWS
/// account. Includes any
/// Amazon S3 buckets designated for storing call detail records.
pub const BusinessCallingSettings = struct {
    /// The Amazon S3 bucket designated for call detail record storage.
    cdr_bucket: ?[]const u8 = null,

    pub const json_field_names = .{
        .cdr_bucket = "CdrBucket",
    };
};
