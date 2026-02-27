const ReferrerPolicyList = @import("referrer_policy_list.zig").ReferrerPolicyList;

/// Determines whether CloudFront includes the `Referrer-Policy` HTTP response
/// header and the header's value.
///
/// For more information about the `Referrer-Policy` HTTP response header, see
/// [Referrer-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy) in the MDN Web Docs.
pub const ResponseHeadersPolicyReferrerPolicy = struct {
    /// A Boolean that determines whether CloudFront overrides the `Referrer-Policy`
    /// HTTP response header received from the origin with the one specified in this
    /// response headers policy.
    override: bool,

    /// The value of the `Referrer-Policy` HTTP response header. Valid values are:
    ///
    /// * `no-referrer`
    /// * `no-referrer-when-downgrade`
    /// * `origin`
    /// * `origin-when-cross-origin`
    /// * `same-origin`
    /// * `strict-origin`
    /// * `strict-origin-when-cross-origin`
    /// * `unsafe-url`
    ///
    /// For more information about these values, see
    /// [Referrer-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy) in the MDN Web Docs.
    referrer_policy: ReferrerPolicyList,
};
