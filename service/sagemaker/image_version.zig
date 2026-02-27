const ImageVersionStatus = @import("image_version_status.zig").ImageVersionStatus;

/// A version of a SageMaker AI `Image`. A version represents an existing
/// container image.
pub const ImageVersion = struct {
    /// When the version was created.
    creation_time: i64,

    /// When a create or delete operation fails, the reason for the failure.
    failure_reason: ?[]const u8,

    /// The ARN of the image the version is based on.
    image_arn: []const u8,

    /// The ARN of the version.
    image_version_arn: []const u8,

    /// The status of the version.
    image_version_status: ImageVersionStatus,

    /// When the version was last modified.
    last_modified_time: i64,

    /// The version number.
    version: i32,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .image_arn = "ImageArn",
        .image_version_arn = "ImageVersionArn",
        .image_version_status = "ImageVersionStatus",
        .last_modified_time = "LastModifiedTime",
        .version = "Version",
    };
};
