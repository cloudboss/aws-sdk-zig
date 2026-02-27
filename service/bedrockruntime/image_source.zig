const S3Location = @import("s3_location.zig").S3Location;

/// The source for an image.
pub const ImageSource = union(enum) {
    /// The raw image bytes for the image. If you use an AWS SDK, you don't need to
    /// encode the image bytes in base64.
    bytes: ?[]const u8,
    /// The location of an image object in an Amazon S3 bucket. To see which models
    /// support S3 uploads, see [Supported models and features for
    /// Converse](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference-supported-models-features.html).
    s_3_location: ?S3Location,

    pub const json_field_names = .{
        .bytes = "bytes",
        .s_3_location = "s3Location",
    };
};
