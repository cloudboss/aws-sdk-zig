const S3Object = @import("s3_object.zig").S3Object;

/// Video file stored in an Amazon S3 bucket. Amazon Rekognition video start
/// operations such as StartLabelDetection use `Video` to
/// specify a video for analysis. The supported file formats are .mp4, .mov and
/// .avi.
pub const Video = struct {
    /// The Amazon S3 bucket name and file name for the video.
    s3_object: ?S3Object,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
