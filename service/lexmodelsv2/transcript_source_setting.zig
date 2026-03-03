const S3BucketTranscriptSource = @import("s3_bucket_transcript_source.zig").S3BucketTranscriptSource;

/// Indicates the setting of the location where the transcript is
/// stored.
pub const TranscriptSourceSetting = struct {
    /// Indicates the setting of the Amazon S3 bucket where the transcript is
    /// stored.
    s_3_bucket_transcript_source: ?S3BucketTranscriptSource = null,

    pub const json_field_names = .{
        .s_3_bucket_transcript_source = "s3BucketTranscriptSource",
    };
};
