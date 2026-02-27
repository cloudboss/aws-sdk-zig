const MimeType = @import("mime_type.zig").MimeType;

/// Metadata information about an uploaded image file.
pub const ImageMetadata = struct {
    /// The file extension of the image.
    file_extension: []const u8,

    /// The timestamp when the image was last uploaded.
    last_upload_timestamp: i64,

    /// The MIME type of the image.
    mime_type: MimeType,

    pub const json_field_names = .{
        .file_extension = "fileExtension",
        .last_upload_timestamp = "lastUploadTimestamp",
        .mime_type = "mimeType",
    };
};
