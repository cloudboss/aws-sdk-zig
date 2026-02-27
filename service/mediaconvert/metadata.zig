/// Metadata and other file information.
pub const Metadata = struct {
    /// The entity tag (ETag) of the file.
    e_tag: ?[]const u8,

    /// The size of the media file, in bytes.
    file_size: ?i64,

    /// The last modification timestamp of the media file, in Unix time.
    last_modified: ?i64,

    /// The MIME type of the media file.
    mime_type: ?[]const u8,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .file_size = "FileSize",
        .last_modified = "LastModified",
        .mime_type = "MimeType",
    };
};
