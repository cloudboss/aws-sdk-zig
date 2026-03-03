const OriginRequestPolicyQueryStringBehavior = @import("origin_request_policy_query_string_behavior.zig").OriginRequestPolicyQueryStringBehavior;
const QueryStringNames = @import("query_string_names.zig").QueryStringNames;

/// An object that determines whether any URL query strings in viewer requests
/// (and if so, which query strings) are included in requests that CloudFront
/// sends to the origin.
pub const OriginRequestPolicyQueryStringsConfig = struct {
    /// Determines whether any URL query strings in viewer requests are included in
    /// requests that CloudFront sends to the origin. Valid values are:
    ///
    /// * `none` – No query strings in viewer requests are included in requests that
    ///   CloudFront sends to the origin. Even when this field is set to `none`, any
    ///   query strings that are listed in a `CachePolicy` *are* included in origin
    ///   requests.
    /// * `whitelist` – Only the query strings in viewer requests that are listed in
    ///   the `QueryStringNames` type are included in requests that CloudFront sends
    ///   to the origin.
    /// * `all` – All query strings in viewer requests are included in requests that
    ///   CloudFront sends to the origin.
    /// * `allExcept` – All query strings in viewer requests are included in
    ///   requests that CloudFront sends to the origin, * **except** * for those
    ///   listed in the `QueryStringNames` type, which are not included.
    query_string_behavior: OriginRequestPolicyQueryStringBehavior,

    /// Contains the specific query strings in viewer requests that either * **are**
    /// * or * **are not** * included in requests that CloudFront sends to the
    /// origin. The behavior depends on whether the `QueryStringBehavior` field in
    /// the `OriginRequestPolicyQueryStringsConfig` type is set to `whitelist` (the
    /// listed query strings * **are** * included) or `allExcept` (the listed query
    /// strings * **are not** * included, but all other query strings are).
    query_strings: ?QueryStringNames = null,
};
