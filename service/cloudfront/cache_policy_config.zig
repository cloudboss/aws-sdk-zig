const ParametersInCacheKeyAndForwardedToOrigin = @import("parameters_in_cache_key_and_forwarded_to_origin.zig").ParametersInCacheKeyAndForwardedToOrigin;

/// A cache policy configuration.
///
/// This configuration determines the following:
///
/// * The values that CloudFront includes in the cache key. These values can
///   include HTTP headers, cookies, and URL query strings. CloudFront uses the
///   cache key to find an object in its cache that it can return to the viewer.
/// * The default, minimum, and maximum time to live (TTL) values that you want
///   objects to stay in the CloudFront cache.
///
/// If your minimum TTL is greater than 0, CloudFront will cache content for at
/// least the duration specified in the cache policy's minimum TTL, even if the
/// `Cache-Control: no-cache`, `no-store`, or `private` directives are present
/// in the origin headers.
///
/// The headers, cookies, and query strings that are included in the cache key
/// are also included in requests that CloudFront sends to the origin.
/// CloudFront sends a request when it can't find a valid object in its cache
/// that matches the request's cache key. If you want to send values to the
/// origin but *not* include them in the cache key, use `OriginRequestPolicy`.
pub const CachePolicyConfig = struct {
    /// A comment to describe the cache policy. The comment cannot be longer than
    /// 128 characters.
    comment: ?[]const u8 = null,

    /// The default amount of time, in seconds, that you want objects to stay in the
    /// CloudFront cache before CloudFront sends another request to the origin to
    /// see if the object has been updated. CloudFront uses this value as the
    /// object's time to live (TTL) only when the origin does *not* send
    /// `Cache-Control` or `Expires` headers with the object. For more information,
    /// see [Managing How Long Content Stays in an Edge Cache
    /// (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.
    ///
    /// The default value for this field is 86400 seconds (one day). If the value of
    /// `MinTTL` is more than 86400 seconds, then the default value for this field
    /// is the same as the value of `MinTTL`.
    default_ttl: ?i64 = null,

    /// The maximum amount of time, in seconds, that objects stay in the CloudFront
    /// cache before CloudFront sends another request to the origin to see if the
    /// object has been updated. CloudFront uses this value only when the origin
    /// sends `Cache-Control` or `Expires` headers with the object. For more
    /// information, see [Managing How Long Content Stays in an Edge Cache
    /// (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.
    ///
    /// The default value for this field is 31536000 seconds (one year). If the
    /// value of `MinTTL` or `DefaultTTL` is more than 31536000 seconds, then the
    /// default value for this field is the same as the value of `DefaultTTL`.
    max_ttl: ?i64 = null,

    /// The minimum amount of time, in seconds, that you want objects to stay in the
    /// CloudFront cache before CloudFront sends another request to the origin to
    /// see if the object has been updated. For more information, see [Managing How
    /// Long Content Stays in an Edge Cache
    /// (Expiration)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Expiration.html) in the *Amazon CloudFront Developer Guide*.
    min_ttl: i64,

    /// A unique name to identify the cache policy.
    name: []const u8,

    /// The HTTP headers, cookies, and URL query strings to include in the cache
    /// key. The values included in the cache key are also included in requests that
    /// CloudFront sends to the origin.
    parameters_in_cache_key_and_forwarded_to_origin: ?ParametersInCacheKeyAndForwardedToOrigin = null,
};
