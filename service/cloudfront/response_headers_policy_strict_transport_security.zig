/// Determines whether CloudFront includes the `Strict-Transport-Security` HTTP
/// response header and the header's value.
///
/// For more information about the `Strict-Transport-Security` HTTP response
/// header, see
/// [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) in the MDN Web Docs.
pub const ResponseHeadersPolicyStrictTransportSecurity = struct {
    /// A number that CloudFront uses as the value for the `max-age` directive in
    /// the `Strict-Transport-Security` HTTP response header.
    access_control_max_age_sec: i32,

    /// A Boolean that determines whether CloudFront includes the
    /// `includeSubDomains` directive in the `Strict-Transport-Security` HTTP
    /// response header.
    include_subdomains: ?bool = null,

    /// A Boolean that determines whether CloudFront overrides the
    /// `Strict-Transport-Security` HTTP response header received from the origin
    /// with the one specified in this response headers policy.
    override: bool,

    /// A Boolean that determines whether CloudFront includes the `preload`
    /// directive in the `Strict-Transport-Security` HTTP response header.
    preload: ?bool = null,
};
