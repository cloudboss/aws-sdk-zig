const ImageSource = @import("image_source.zig").ImageSource;

/// The logo image.
pub const Image = struct {
    /// The URL that points to the generated logo image.
    generated_image_url: ?[]const u8 = null,

    /// The source of the logo image.
    source: ?ImageSource = null,

    pub const json_field_names = .{
        .generated_image_url = "GeneratedImageUrl",
        .source = "Source",
    };
};
