const PathFormat = @import("path_format.zig").PathFormat;
const TranscriptFilter = @import("transcript_filter.zig").TranscriptFilter;
const TranscriptFormat = @import("transcript_format.zig").TranscriptFormat;

/// The object representing the Amazon S3 bucket containing the transcript,
/// as well as the associated metadata.
pub const S3BucketTranscriptSource = struct {
    /// The ARN of the KMS key that customer use to encrypt their Amazon S3
    /// bucket. Only use this field if your bucket is encrypted using a
    /// customer managed KMS key.
    kms_key_arn: ?[]const u8 = null,

    /// The object that contains a path format that will be applied when
    /// Amazon Lex reads the transcript file in the bucket you provide. Specify this
    /// object if you only want Lex to read a subset of files in your Amazon S3
    /// bucket.
    path_format: ?PathFormat = null,

    /// The name of the bucket containing the transcript and the associated
    /// metadata.
    s_3_bucket_name: []const u8,

    /// The object that contains the filter which will be applied when Amazon Lex
    /// reads through the Amazon S3 bucket. Specify this object if you want Amazon
    /// Lex to
    /// read only a subset of the Amazon S3 bucket based on the filter you
    /// provide.
    transcript_filter: ?TranscriptFilter = null,

    /// The format of the transcript content. Currently, Genie only supports
    /// the Amazon Lex transcript format.
    transcript_format: TranscriptFormat,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .path_format = "pathFormat",
        .s_3_bucket_name = "s3BucketName",
        .transcript_filter = "transcriptFilter",
        .transcript_format = "transcriptFormat",
    };
};
