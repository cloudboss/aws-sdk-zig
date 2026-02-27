const S3Presign = @import("s3_presign.zig").S3Presign;

/// Use this optional parameter to constrain access to an Amazon S3 resource
/// based on the IP address using supported IAM global condition keys. The
/// Amazon S3 resource is accessed in the worker portal using a Amazon S3
/// presigned URL.
pub const WorkerAccessConfiguration = struct {
    /// Defines any Amazon S3 resource constraints.
    s3_presign: ?S3Presign,

    pub const json_field_names = .{
        .s3_presign = "S3Presign",
    };
};
