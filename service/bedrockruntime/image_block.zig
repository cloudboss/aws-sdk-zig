const ErrorBlock = @import("error_block.zig").ErrorBlock;
const ImageFormat = @import("image_format.zig").ImageFormat;
const ImageSource = @import("image_source.zig").ImageSource;

/// Image content for a message.
pub const ImageBlock = struct {
    /// Error information if the image block could not be processed or contains
    /// invalid data.
    @"error": ?ErrorBlock = null,

    /// The format of the image.
    format: ImageFormat,

    /// The source for the image.
    source: ImageSource,

    pub const json_field_names = .{
        .@"error" = "error",
        .format = "format",
        .source = "source",
    };
};
