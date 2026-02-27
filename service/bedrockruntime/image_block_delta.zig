const ErrorBlock = @import("error_block.zig").ErrorBlock;
const ImageSource = @import("image_source.zig").ImageSource;

/// A streaming delta event that contains incremental image data during
/// streaming responses.
pub const ImageBlockDelta = struct {
    /// Error information if this image delta could not be processed.
    @"error": ?ErrorBlock,

    /// The incremental image source data for this delta event.
    source: ?ImageSource,

    pub const json_field_names = .{
        .@"error" = "error",
        .source = "source",
    };
};
