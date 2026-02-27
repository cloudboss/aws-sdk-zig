const S3InputFormat = @import("s3_input_format.zig").S3InputFormat;

/// Contains the configuration of the S3 location of the input data.
pub const ModelInvocationJobS3InputDataConfig = struct {
    /// The ID of the Amazon Web Services account that owns the S3 bucket containing
    /// the input data.
    s_3_bucket_owner: ?[]const u8,

    /// The format of the input data.
    s_3_input_format: ?S3InputFormat,

    /// The S3 location of the input data.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_input_format = "s3InputFormat",
        .s_3_uri = "s3Uri",
    };
};
