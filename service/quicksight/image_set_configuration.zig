const ImageConfiguration = @import("image_configuration.zig").ImageConfiguration;

/// The image set configuration.
pub const ImageSetConfiguration = struct {
    /// The original image.
    original: ImageConfiguration,

    pub const json_field_names = .{
        .original = "Original",
    };
};
