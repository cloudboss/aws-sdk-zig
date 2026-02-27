/// Contains information for the S3 bucket that contains media files.
pub const S3File = struct {
    /// The bucket name.
    bucket_name: []const u8,

    /// The S3 key prefix that defines the storage location of your media files. The
    /// prefix works like a folder path in S3,
    /// and is combined with the WhatsApp mediaId to create the final file path.
    ///
    /// For example, if a media file's WhatsApp mediaId is `123.ogg`, and the key is
    /// `audio/example.ogg`,
    /// the final file path is `audio/example.ogg123.ogg`.
    ///
    /// For the same mediaId, a key of `audio/` results in the file path
    /// `audio/123.ogg`.
    key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
    };
};
