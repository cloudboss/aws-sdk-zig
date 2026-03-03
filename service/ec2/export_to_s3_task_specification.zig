const ContainerFormat = @import("container_format.zig").ContainerFormat;
const DiskImageFormat = @import("disk_image_format.zig").DiskImageFormat;

/// Describes an export instance task.
pub const ExportToS3TaskSpecification = struct {
    /// The container format used to combine disk images with metadata (such as
    /// OVF). If absent, only the disk image is
    /// exported.
    container_format: ?ContainerFormat = null,

    /// The format for the exported image.
    disk_image_format: ?DiskImageFormat = null,

    /// The Amazon S3 bucket for the destination image. The destination bucket must
    /// exist and have
    /// an access control list (ACL) attached that specifies the Region-specific
    /// canonical account ID for
    /// the `Grantee`. For more information about the ACL to your S3 bucket, see
    /// [Prerequisites](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html#vmexport-prerequisites) in the VM Import/Export User Guide.
    s3_bucket: ?[]const u8 = null,

    /// The image is written to a single object in the Amazon S3 bucket at the S3
    /// key s3prefix +
    /// exportTaskId + '.' + diskImageFormat.
    s3_prefix: ?[]const u8 = null,
};
