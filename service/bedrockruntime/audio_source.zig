const S3Location = @import("s3_location.zig").S3Location;

/// The source of audio data, which can be provided either as raw bytes or a
/// reference to an S3 location.
pub const AudioSource = union(enum) {
    /// Audio data encoded in base64.
    bytes: ?[]const u8,
    /// A reference to audio data stored in an Amazon S3 bucket. To see which models
    /// support S3 uploads, see [Supported models and features for
    /// Converse](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference-supported-models-features.html).
    s_3_location: ?S3Location,

    pub const json_field_names = .{
        .bytes = "bytes",
        .s_3_location = "s3Location",
    };
};
