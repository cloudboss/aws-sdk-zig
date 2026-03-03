/// Details about an image source, including its identifier and format.
pub const ImageSourceDetails = struct {
    /// Unique identifier for the image file.
    media_id: ?[]const u8 = null,

    /// The MIME type of the image file.
    media_mime_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_id = "mediaId",
        .media_mime_type = "mediaMimeType",
    };
};
