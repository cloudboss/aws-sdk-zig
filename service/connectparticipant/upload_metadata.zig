const aws = @import("aws");

/// Fields to be used while uploading the attachment.
pub const UploadMetadata = struct {
    /// The headers to be provided while uploading the file to the URL.
    headers_to_include: ?[]const aws.map.StringMapEntry = null,

    /// This is the pre-signed URL that can be used for uploading the file to Amazon
    /// S3 when used in response
    /// to
    /// [StartAttachmentUpload](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_StartAttachmentUpload.html).
    url: ?[]const u8 = null,

    /// The expiration time of the URL in ISO timestamp. It's specified in ISO 8601
    /// format: yyyy-MM-ddThh:mm:ss.SSSZ. For example, 2019-11-08T02:41:28.172Z.
    url_expiry: ?[]const u8 = null,

    pub const json_field_names = .{
        .headers_to_include = "HeadersToInclude",
        .url = "Url",
        .url_expiry = "UrlExpiry",
    };
};
