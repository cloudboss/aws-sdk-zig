const ReferencedImageDetail = @import("referenced_image_detail.zig").ReferencedImageDetail;

/// An object that represents the image tag details for an image.
pub const ImageTagDetail = struct {
    /// The time stamp that indicates when the image tag was created.
    created_at: ?i64,

    /// An object that describes the details of an image.
    image_detail: ?ReferencedImageDetail,

    /// The tag that's associated with the image.
    image_tag: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_detail = "imageDetail",
        .image_tag = "imageTag",
    };
};
