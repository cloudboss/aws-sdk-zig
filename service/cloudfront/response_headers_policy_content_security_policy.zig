/// The policy directives and their values that CloudFront includes as values
/// for the `Content-Security-Policy` HTTP response header.
///
/// For more information about the `Content-Security-Policy` HTTP response
/// header, see
/// [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) in the MDN Web Docs.
pub const ResponseHeadersPolicyContentSecurityPolicy = struct {
    /// The policy directives and their values that CloudFront includes as values
    /// for the `Content-Security-Policy` HTTP response header.
    content_security_policy: []const u8,

    /// A Boolean that determines whether CloudFront overrides the
    /// `Content-Security-Policy` HTTP response header received from the origin with
    /// the one specified in this response headers policy.
    override: bool,
};
