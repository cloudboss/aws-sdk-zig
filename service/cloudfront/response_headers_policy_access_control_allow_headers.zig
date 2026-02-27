/// A list of HTTP header names that CloudFront includes as values for the
/// `Access-Control-Allow-Headers` HTTP response header.
///
/// For more information about the `Access-Control-Allow-Headers` HTTP response
/// header, see
/// [Access-Control-Allow-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers) in the MDN Web Docs.
pub const ResponseHeadersPolicyAccessControlAllowHeaders = struct {
    /// The list of HTTP header names. You can specify `*` to allow all headers.
    items: []const []const u8,

    /// The number of HTTP header names in the list.
    quantity: i32,
};
