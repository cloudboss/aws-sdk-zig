const Image = @import("image.zig").Image;

/// The image set.
pub const ImageSet = struct {
    /// The image with the height set to 32 pixels.
    height_32: ?Image = null,

    /// The image with the height set to 64 pixels.
    height_64: ?Image = null,

    /// The original image.
    original: Image,

    pub const json_field_names = .{
        .height_32 = "Height32",
        .height_64 = "Height64",
        .original = "Original",
    };
};
