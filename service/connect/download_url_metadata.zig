/// Metadata used to download the attached file.
pub const DownloadUrlMetadata = struct {
    /// A pre-signed URL that should be used to download the attached file.
    url: ?[]const u8,

    /// The expiration time of the URL in ISO timestamp. It's specified in ISO 8601
    /// format: yyyy-MM-ddThh:mm:ss.SSSZ.
    /// For example, 2019-11-08T02:41:28.172Z.
    url_expiry: ?[]const u8,

    pub const json_field_names = .{
        .url = "Url",
        .url_expiry = "UrlExpiry",
    };
};
