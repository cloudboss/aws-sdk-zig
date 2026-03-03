/// Contains details regarding the file source.
pub const FileSource = struct {
    /// The digest of the file source.
    content_digest: ?[]const u8 = null,

    /// The type of content stored in the file source.
    content_type: ?[]const u8 = null,

    /// The Amazon S3 URI for the file source.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .content_digest = "ContentDigest",
        .content_type = "ContentType",
        .s3_uri = "S3Uri",
    };
};
