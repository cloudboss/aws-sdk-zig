const CookieObject = @import("cookie_object.zig").CookieObject;
const HeaderObject = @import("header_object.zig").HeaderObject;
const QueryStringObject = @import("query_string_object.zig").QueryStringObject;

/// Describes the cache settings of an Amazon Lightsail content delivery network
/// (CDN)
/// distribution.
///
/// These settings apply only to your distribution's `cacheBehaviors` (including
/// the `defaultCacheBehavior`) that have a `behavior` of
/// `cache`.
pub const CacheSettings = struct {
    /// The HTTP methods that are processed and forwarded to the distribution's
    /// origin.
    ///
    /// You can specify the following options:
    ///
    /// * `GET,HEAD` - The distribution forwards the `GET` and
    /// `HEAD` methods.
    ///
    /// * `GET,HEAD,OPTIONS` - The distribution forwards the `GET`,
    /// `HEAD`, and `OPTIONS` methods.
    ///
    /// * `GET,HEAD,OPTIONS,PUT,PATCH,POST,DELETE` - The distribution forwards the
    /// `GET`, `HEAD`, `OPTIONS`, `PUT`,
    /// `PATCH`, `POST`, and `DELETE` methods.
    ///
    /// If you specify the third option, you might need to restrict access to your
    /// distribution's
    /// origin so users can't perform operations that you don't want them to. For
    /// example, you might
    /// not want users to have permission to delete objects from your origin.
    allowed_http_methods: ?[]const u8,

    /// The HTTP method responses that are cached by your distribution.
    ///
    /// You can specify the following options:
    ///
    /// * `GET,HEAD` - The distribution caches responses to the `GET` and
    /// `HEAD` methods.
    ///
    /// * `GET,HEAD,OPTIONS` - The distribution caches responses to the
    /// `GET`, `HEAD`, and `OPTIONS` methods.
    cached_http_methods: ?[]const u8,

    /// The default amount of time that objects stay in the distribution's cache
    /// before the
    /// distribution forwards another request to the origin to determine whether the
    /// content has been
    /// updated.
    ///
    /// The value specified applies only when the origin does not add HTTP headers
    /// such as
    /// `Cache-Control max-age`, `Cache-Control s-maxage`, and
    /// `Expires` to objects.
    default_ttl: ?i64,

    /// An object that describes the cookies that are forwarded to the origin. Your
    /// content is
    /// cached based on the cookies that are forwarded.
    forwarded_cookies: ?CookieObject,

    /// An object that describes the headers that are forwarded to the origin. Your
    /// content is
    /// cached based on the headers that are forwarded.
    forwarded_headers: ?HeaderObject,

    /// An object that describes the query strings that are forwarded to the origin.
    /// Your content
    /// is cached based on the query strings that are forwarded.
    forwarded_query_strings: ?QueryStringObject,

    /// The maximum amount of time that objects stay in the distribution's cache
    /// before the
    /// distribution forwards another request to the origin to determine whether the
    /// object has been
    /// updated.
    ///
    /// The value specified applies only when the origin adds HTTP headers such as
    /// `Cache-Control max-age`, `Cache-Control s-maxage`, and
    /// `Expires` to objects.
    maximum_ttl: ?i64,

    /// The minimum amount of time that objects stay in the distribution's cache
    /// before the
    /// distribution forwards another request to the origin to determine whether the
    /// object has been
    /// updated.
    ///
    /// A value of `0` must be specified for `minimumTTL` if the
    /// distribution is configured to forward all headers to the origin.
    minimum_ttl: ?i64,

    pub const json_field_names = .{
        .allowed_http_methods = "allowedHTTPMethods",
        .cached_http_methods = "cachedHTTPMethods",
        .default_ttl = "defaultTTL",
        .forwarded_cookies = "forwardedCookies",
        .forwarded_headers = "forwardedHeaders",
        .forwarded_query_strings = "forwardedQueryStrings",
        .maximum_ttl = "maximumTTL",
        .minimum_ttl = "minimumTTL",
    };
};
