/// Determines whether CloudFront includes the `X-Content-Type-Options` HTTP
/// response header with its value set to `nosniff`.
///
/// For more information about the `X-Content-Type-Options` HTTP response
/// header, see
/// [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) in the MDN Web Docs.
pub const ResponseHeadersPolicyContentTypeOptions = struct {
    /// A Boolean that determines whether CloudFront overrides the
    /// `X-Content-Type-Options` HTTP response header received from the origin with
    /// the one specified in this response headers policy.
    override: bool,
};
