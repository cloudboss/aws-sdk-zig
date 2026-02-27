/// A list of origins (domain names) that CloudFront can use as the value for
/// the `Access-Control-Allow-Origin` HTTP response header.
///
/// For more information about the `Access-Control-Allow-Origin` HTTP response
/// header, see
/// [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
pub const ResponseHeadersPolicyAccessControlAllowOrigins = struct {
    /// The list of origins (domain names). You can specify `*` to allow all
    /// origins.
    items: []const []const u8,

    /// The number of origins in the list.
    quantity: i32,
};
