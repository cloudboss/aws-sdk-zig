const ImageFile = @import("image_file.zig").ImageFile;

/// Contains an image that is one of the following:
///
/// * An image file. Choose this option to upload a new image.
///
/// * The ID of an existing image. Choose this option to keep an existing image.
pub const Image = struct {
    file: ?ImageFile = null,

    /// The ID of an existing image. Specify this parameter to keep an existing
    /// image.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .file = "file",
        .id = "id",
    };
};
