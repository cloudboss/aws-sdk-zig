const S3Object = @import("s3_object.zig").S3Object;

/// The S3 bucket that contains the training summary. The training summary
/// includes
/// aggregated evaluation metrics for the entire testing dataset and metrics for
/// each
/// individual label.
///
/// You get the training summary S3 bucket location by calling
/// DescribeProjectVersions.
pub const Summary = struct {
    s3_object: ?S3Object,

    pub const json_field_names = .{
        .s3_object = "S3Object",
    };
};
