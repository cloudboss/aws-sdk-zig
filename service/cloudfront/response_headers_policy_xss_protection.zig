/// Determines whether CloudFront includes the `X-XSS-Protection` HTTP response
/// header and the header's value.
///
/// For more information about the `X-XSS-Protection` HTTP response header, see
/// [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
pub const ResponseHeadersPolicyXSSProtection = struct {
    /// A Boolean that determines whether CloudFront includes the `mode=block`
    /// directive in the `X-XSS-Protection` header.
    ///
    /// For more information about this directive, see
    /// [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
    mode_block: ?bool,

    /// A Boolean that determines whether CloudFront overrides the
    /// `X-XSS-Protection` HTTP response header received from the origin with the
    /// one specified in this response headers policy.
    override: bool,

    /// A Boolean that determines the value of the `X-XSS-Protection` HTTP response
    /// header. When this setting is `true`, the value of the `X-XSS-Protection`
    /// header is `1`. When this setting is `false`, the value of the
    /// `X-XSS-Protection` header is `0`.
    ///
    /// For more information about these settings, see
    /// [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
    protection: bool,

    /// A reporting URI, which CloudFront uses as the value of the `report`
    /// directive in the `X-XSS-Protection` header.
    ///
    /// You cannot specify a `ReportUri` when `ModeBlock` is `true`.
    ///
    /// For more information about using a reporting URL, see
    /// [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
    report_uri: ?[]const u8,
};
