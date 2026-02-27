const CachePolicyQueryStringBehavior = @import("cache_policy_query_string_behavior.zig").CachePolicyQueryStringBehavior;
const QueryStringNames = @import("query_string_names.zig").QueryStringNames;

/// An object that determines whether any URL query strings in viewer requests
/// (and if so, which query strings) are included in the cache key and in
/// requests that CloudFront sends to the origin.
pub const CachePolicyQueryStringsConfig = struct {
    /// Determines whether any URL query strings in viewer requests are included in
    /// the cache key and in requests that CloudFront sends to the origin. Valid
    /// values are:
    ///
    /// * `none` – No query strings in viewer requests are included in the cache key
    ///   or in requests that CloudFront sends to the origin. Even when this field
    ///   is set to `none`, any query strings that are listed in an
    ///   `OriginRequestPolicy` *are* included in origin requests.
    /// * `whitelist` – Only the query strings in viewer requests that are listed in
    ///   the `QueryStringNames` type are included in the cache key and in requests
    ///   that CloudFront sends to the origin.
    /// * `allExcept` – All query strings in viewer requests are included in the
    ///   cache key and in requests that CloudFront sends to the origin, *
    ///   **except** * those that are listed in the `QueryStringNames` type, which
    ///   are not included.
    /// * `all` – All query strings in viewer requests are included in the cache key
    ///   and in requests that CloudFront sends to the origin.
    query_string_behavior: CachePolicyQueryStringBehavior,

    /// Contains the specific query strings in viewer requests that either * **are**
    /// * or * **are not** * included in the cache key and in requests that
    /// CloudFront sends to the origin. The behavior depends on whether the
    /// `QueryStringBehavior` field in the `CachePolicyQueryStringsConfig` type is
    /// set to `whitelist` (the listed query strings * **are** * included) or
    /// `allExcept` (the listed query strings * **are not** * included, but all
    /// other query strings are).
    query_strings: ?QueryStringNames,
};
