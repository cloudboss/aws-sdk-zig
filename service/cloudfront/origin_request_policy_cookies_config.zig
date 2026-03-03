const OriginRequestPolicyCookieBehavior = @import("origin_request_policy_cookie_behavior.zig").OriginRequestPolicyCookieBehavior;
const CookieNames = @import("cookie_names.zig").CookieNames;

/// An object that determines whether any cookies in viewer requests (and if so,
/// which cookies) are included in requests that CloudFront sends to the origin.
pub const OriginRequestPolicyCookiesConfig = struct {
    /// Determines whether cookies in viewer requests are included in requests that
    /// CloudFront sends to the origin. Valid values are:
    ///
    /// * `none` – No cookies in viewer requests are included in requests that
    ///   CloudFront sends to the origin. Even when this field is set to `none`, any
    ///   cookies that are listed in a `CachePolicy` *are* included in origin
    ///   requests.
    /// * `whitelist` – Only the cookies in viewer requests that are listed in the
    ///   `CookieNames` type are included in requests that CloudFront sends to the
    ///   origin.
    /// * `all` – All cookies in viewer requests are included in requests that
    ///   CloudFront sends to the origin.
    /// * `allExcept` – All cookies in viewer requests are included in requests that
    ///   CloudFront sends to the origin, * **except** * for those listed in the
    ///   `CookieNames` type, which are not included.
    cookie_behavior: OriginRequestPolicyCookieBehavior,

    cookies: ?CookieNames = null,
};
