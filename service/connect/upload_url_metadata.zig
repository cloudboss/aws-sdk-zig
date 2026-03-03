const aws = @import("aws");

/// Fields required when uploading an attached file.
pub const UploadUrlMetadata = struct {
    /// A map of headers that should be provided when uploading the attached file.
    headers_to_include: ?[]const aws.map.StringMapEntry = null,

    /// A pre-signed S3 URL that should be used for uploading the attached file.
    url: ?[]const u8 = null,

    /// The expiration time of the URL in ISO timestamp. It's specified in ISO 8601
    /// format:
    /// `yyyy-MM-ddThh:mm:ss.SSSZ`. For example, `2019-11-08T02:41:28.172Z`.
    url_expiry: ?[]const u8 = null,

    pub const json_field_names = .{
        .headers_to_include = "HeadersToInclude",
        .url = "Url",
        .url_expiry = "UrlExpiry",
    };
};
