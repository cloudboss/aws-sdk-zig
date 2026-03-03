const ImageReferenceResourceType = @import("image_reference_resource_type.zig").ImageReferenceResourceType;

/// A resource that is referencing an image.
pub const ImageReference = struct {
    /// The Amazon Resource Name (ARN) of the resource referencing the image.
    arn: ?[]const u8 = null,

    /// The ID of the referenced image.
    image_id: ?[]const u8 = null,

    /// The type of resource referencing the image.
    resource_type: ?ImageReferenceResourceType = null,
};
