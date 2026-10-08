const ImageFileType = @import("image_file_type.zig").ImageFileType;

/// Contains an image file.
pub const ImageFile = struct {
    /// The image file contents, represented as a base64-encoded string. The file
    /// size must be
    /// less than 1 MB.
    data: []const u8,

    /// The file type of the image.
    type: ImageFileType,

    pub const json_field_names = .{
        .data = "data",
        .type = "type",
    };
};
