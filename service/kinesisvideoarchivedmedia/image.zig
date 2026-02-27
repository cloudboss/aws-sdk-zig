const ImageError = @import("image_error.zig").ImageError;

/// A structure that contains the `Timestamp`, `Error`, and `ImageContent`.
pub const Image = struct {
    /// The error message shown when the image for the provided timestamp was not
    /// extracted due to a non-tryable error. An error will be returned if:
    ///
    /// * There is no media that exists for the specified `Timestamp`.
    ///
    /// * The media for the specified time does not allow an image to be extracted.
    ///   In this case the media is audio only, or the incorrect
    /// media has been ingested.
    @"error": ?ImageError,

    /// An attribute of the `Image` object that is Base64 encoded.
    image_content: ?[]const u8,

    /// An attribute of the `Image` object that is used to extract an image from the
    /// video stream. This field is used to manage gaps on images or to better
    /// understand the pagination
    /// window.
    time_stamp: ?i64,

    pub const json_field_names = .{
        .@"error" = "Error",
        .image_content = "ImageContent",
        .time_stamp = "TimeStamp",
    };
};
