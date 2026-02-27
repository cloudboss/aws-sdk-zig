/// A complex type that contains `HeaderName` and `HeaderValue` elements, if
/// any, for this distribution.
pub const OriginCustomHeader = struct {
    /// The name of a header that you want CloudFront to send to your origin. For
    /// more information, see [Adding Custom Headers to Origin
    /// Requests](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/forward-custom-headers.html) in the * Amazon CloudFront Developer Guide*.
    header_name: []const u8,

    /// The value for the header that you specified in the `HeaderName` field.
    header_value: []const u8,
};
