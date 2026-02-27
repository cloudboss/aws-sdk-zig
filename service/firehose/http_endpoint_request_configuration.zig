const HttpEndpointCommonAttribute = @import("http_endpoint_common_attribute.zig").HttpEndpointCommonAttribute;
const ContentEncoding = @import("content_encoding.zig").ContentEncoding;

/// The configuration of the HTTP endpoint request.
pub const HttpEndpointRequestConfiguration = struct {
    /// Describes the metadata sent to the HTTP endpoint destination.
    common_attributes: ?[]const HttpEndpointCommonAttribute,

    /// Firehose uses the content encoding to compress the body of a request before
    /// sending the request to the destination. For more information, see
    /// [Content-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) in MDN Web Docs, the official Mozilla documentation.
    content_encoding: ?ContentEncoding,

    pub const json_field_names = .{
        .common_attributes = "CommonAttributes",
        .content_encoding = "ContentEncoding",
    };
};
