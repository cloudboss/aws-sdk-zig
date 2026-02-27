const ImageFormat = @import("image_format.zig").ImageFormat;
const ImageSource = @import("image_source.zig").ImageSource;

/// Image content for an invocation step.
pub const ImageBlock = struct {
    /// The format of the image.
    format: ImageFormat,

    /// The source for the image.
    source: ImageSource,

    pub const json_field_names = .{
        .format = "format",
        .source = "source",
    };
};
