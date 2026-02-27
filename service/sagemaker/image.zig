const ImageStatus = @import("image_status.zig").ImageStatus;

/// A SageMaker AI image. A SageMaker AI image represents a set of container
/// images that are derived from a common base container image. Each of these
/// container images is represented by a SageMaker AI `ImageVersion`.
pub const Image = struct {
    /// When the image was created.
    creation_time: i64,

    /// The description of the image.
    description: ?[]const u8,

    /// The name of the image as displayed.
    display_name: ?[]const u8,

    /// When a create, update, or delete operation fails, the reason for the
    /// failure.
    failure_reason: ?[]const u8,

    /// The ARN of the image.
    image_arn: []const u8,

    /// The name of the image.
    image_name: []const u8,

    /// The status of the image.
    image_status: ImageStatus,

    /// When the image was last modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .display_name = "DisplayName",
        .failure_reason = "FailureReason",
        .image_arn = "ImageArn",
        .image_name = "ImageName",
        .image_status = "ImageStatus",
        .last_modified_time = "LastModifiedTime",
    };
};
