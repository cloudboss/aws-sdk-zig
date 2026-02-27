const ImageFormat = @import("image_format.zig").ImageFormat;

/// The initial event in a streaming image block that indicates the start of
/// image content.
pub const ImageBlockStart = struct {
    /// The format of the image data that will be streamed in subsequent delta
    /// events.
    format: ImageFormat,

    pub const json_field_names = .{
        .format = "format",
    };
};
