const aws = @import("aws");

/// You can use presigned URLs to grant time-limited access to objects in Amazon
/// S3 without updating your bucket policy. For more information, see [Working
/// with presigned
/// URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-presigned-url.html) in the *Amazon S3
/// User Guide*.
pub const S3PresignedUrl = struct {
    /// A map of headers and their values. You must specify the `Content-Type`
    /// header when using `PostWhatsAppMessageMedia`. For a list of common headers,
    /// see [Common Request
    /// Headers](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTCommonRequestHeaders.html) in the *Amazon S3
    /// API Reference*
    headers: []const aws.map.StringMapEntry,

    /// The presign url to the object.
    url: []const u8,

    pub const json_field_names = .{
        .headers = "headers",
        .url = "url",
    };
};
