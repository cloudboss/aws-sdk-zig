const RateLimitAsn = @import("rate_limit_asn.zig").RateLimitAsn;
const RateLimitCookie = @import("rate_limit_cookie.zig").RateLimitCookie;
const RateLimitForwardedIP = @import("rate_limit_forwarded_ip.zig").RateLimitForwardedIP;
const RateLimitHeader = @import("rate_limit_header.zig").RateLimitHeader;
const RateLimitHTTPMethod = @import("rate_limit_http_method.zig").RateLimitHTTPMethod;
const RateLimitIP = @import("rate_limit_ip.zig").RateLimitIP;
const RateLimitJA3Fingerprint = @import("rate_limit_ja3_fingerprint.zig").RateLimitJA3Fingerprint;
const RateLimitJA4Fingerprint = @import("rate_limit_ja4_fingerprint.zig").RateLimitJA4Fingerprint;
const RateLimitLabelNamespace = @import("rate_limit_label_namespace.zig").RateLimitLabelNamespace;
const RateLimitQueryArgument = @import("rate_limit_query_argument.zig").RateLimitQueryArgument;
const RateLimitQueryString = @import("rate_limit_query_string.zig").RateLimitQueryString;
const RateLimitUriPath = @import("rate_limit_uri_path.zig").RateLimitUriPath;

/// Specifies a single custom aggregate key for a rate-base rule.
///
/// Web requests that are missing any of the components specified in the
/// aggregation keys
/// are omitted from the rate-based rule evaluation and handling.
pub const RateBasedStatementCustomKey = struct {
    /// Use an Autonomous System Number (ASN) derived from the request's originating
    /// or forwarded IP address as an aggregate key.
    /// Each distinct ASN contributes to the aggregation instance.
    asn: ?RateLimitAsn,

    /// Use the value of a cookie in the request as an aggregate key. Each distinct
    /// value in the cookie contributes to the aggregation instance. If you use a
    /// single
    /// cookie as your custom key, then each value fully defines an aggregation
    /// instance.
    cookie: ?RateLimitCookie,

    /// Use the first IP address in an HTTP header as an aggregate key. Each
    /// distinct forwarded IP address contributes to the aggregation instance.
    ///
    /// When you specify an IP or forwarded IP in the custom key settings, you must
    /// also specify at least one other key to use.
    /// You can aggregate on only the forwarded IP address by specifying
    /// `FORWARDED_IP` in your rate-based statement's `AggregateKeyType`.
    ///
    /// With this option, you must specify the header to use in the rate-based
    /// rule's `ForwardedIPConfig` property.
    forwarded_ip: ?RateLimitForwardedIP,

    /// Use the value of a header in the request as an aggregate key. Each distinct
    /// value in the header contributes to the aggregation instance. If you use a
    /// single
    /// header as your custom key, then each value fully defines an aggregation
    /// instance.
    header: ?RateLimitHeader,

    /// Use the request's HTTP method as an aggregate key. Each distinct HTTP method
    /// contributes to the aggregation instance. If you use just the HTTP method
    /// as your custom key, then each method fully defines an aggregation instance.
    http_method: ?RateLimitHTTPMethod,

    /// Use the request's originating IP address as an aggregate key. Each distinct
    /// IP address contributes to the aggregation instance.
    ///
    /// When you specify an IP or forwarded IP in the custom key settings, you must
    /// also specify at least one other key to use.
    /// You can aggregate on only the IP address by specifying `IP` in your
    /// rate-based statement's `AggregateKeyType`.
    ip: ?RateLimitIP,

    /// Use the request's JA3 fingerprint as an aggregate key. If you use a single
    /// JA3 fingerprint as your custom key, then each value fully defines an
    /// aggregation instance.
    ja3_fingerprint: ?RateLimitJA3Fingerprint,

    /// Use the request's JA4 fingerprint as an aggregate key. If you use a single
    /// JA4 fingerprint as your custom key, then each value fully defines an
    /// aggregation instance.
    ja4_fingerprint: ?RateLimitJA4Fingerprint,

    /// Use the specified label namespace as an aggregate key. Each distinct fully
    /// qualified label name that has the specified label namespace contributes to
    /// the aggregation instance. If you use just one label namespace as your custom
    /// key, then each label name fully defines an aggregation instance.
    ///
    /// This uses only labels that have been added to the request by rules that are
    /// evaluated before this rate-based rule in the web ACL.
    ///
    /// For information about label namespaces and names, see
    /// [Label syntax and naming
    /// requirements](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-label-requirements.html) in the *WAF Developer Guide*.
    label_namespace: ?RateLimitLabelNamespace,

    /// Use the specified query argument as an aggregate key. Each distinct value
    /// for the named query argument contributes to the aggregation instance. If you
    /// use a single query argument as your custom key, then each value fully
    /// defines an aggregation instance.
    query_argument: ?RateLimitQueryArgument,

    /// Use the request's query string as an aggregate key. Each distinct string
    /// contributes to the aggregation instance. If you use just the
    /// query string as your custom key, then each string fully defines an
    /// aggregation instance.
    query_string: ?RateLimitQueryString,

    /// Use the request's URI path as an aggregate key. Each distinct URI path
    /// contributes to the aggregation instance. If you use just the
    /// URI path as your custom key, then each URI path fully defines an aggregation
    /// instance.
    uri_path: ?RateLimitUriPath,

    pub const json_field_names = .{
        .asn = "ASN",
        .cookie = "Cookie",
        .forwarded_ip = "ForwardedIP",
        .header = "Header",
        .http_method = "HTTPMethod",
        .ip = "IP",
        .ja3_fingerprint = "JA3Fingerprint",
        .ja4_fingerprint = "JA4Fingerprint",
        .label_namespace = "LabelNamespace",
        .query_argument = "QueryArgument",
        .query_string = "QueryString",
        .uri_path = "UriPath",
    };
};
