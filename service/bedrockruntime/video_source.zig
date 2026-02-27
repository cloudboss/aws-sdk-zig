const S3Location = @import("s3_location.zig").S3Location;

/// A video source. You can upload a smaller video as a base64-encoded string as
/// long as the encoded file is less than 25MB. You can also transfer videos up
/// to 1GB in size from an S3 bucket.
pub const VideoSource = union(enum) {
    /// Video content encoded in base64.
    bytes: ?[]const u8,
    /// The location of a video object in an Amazon S3 bucket. To see which models
    /// support S3 uploads, see [Supported models and features for
    /// Converse](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference-supported-models-features.html).
    s_3_location: ?S3Location,

    pub const json_field_names = .{
        .bytes = "bytes",
        .s_3_location = "s3Location",
    };
};
