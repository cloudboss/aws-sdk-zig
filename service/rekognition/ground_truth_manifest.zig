const S3Object = @import("s3_object.zig").S3Object;

/// The S3 bucket that contains an Amazon Sagemaker Ground Truth format manifest
/// file.
pub const GroundTruthManifest = struct {
    s3_object: ?S3Object = null,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
