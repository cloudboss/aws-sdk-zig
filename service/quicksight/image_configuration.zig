const ImageSource = @import("image_source.zig").ImageSource;

/// The logo image configuration.
pub const ImageConfiguration = struct {
    /// The source of the image.
    source: ?ImageSource = null,

    pub const json_field_names = .{
        .source = "Source",
    };
};
