/// A list of HTTP headers that CloudFront includes as values for the
/// `Access-Control-Expose-Headers` HTTP response header.
///
/// For more information about the `Access-Control-Expose-Headers` HTTP response
/// header, see
/// [Access-Control-Expose-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
pub const ResponseHeadersPolicyAccessControlExposeHeaders = struct {
    /// The list of HTTP headers. You can specify `*` to expose all headers.
    items: ?[]const []const u8,

    /// The number of HTTP headers in the list.
    quantity: i32,
};
