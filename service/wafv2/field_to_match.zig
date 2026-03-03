const AllQueryArguments = @import("all_query_arguments.zig").AllQueryArguments;
const Body = @import("body.zig").Body;
const Cookies = @import("cookies.zig").Cookies;
const HeaderOrder = @import("header_order.zig").HeaderOrder;
const Headers = @import("headers.zig").Headers;
const JA3Fingerprint = @import("ja3_fingerprint.zig").JA3Fingerprint;
const JA4Fingerprint = @import("ja4_fingerprint.zig").JA4Fingerprint;
const JsonBody = @import("json_body.zig").JsonBody;
const Method = @import("method.zig").Method;
const QueryString = @import("query_string.zig").QueryString;
const SingleHeader = @import("single_header.zig").SingleHeader;
const SingleQueryArgument = @import("single_query_argument.zig").SingleQueryArgument;
const UriFragment = @import("uri_fragment.zig").UriFragment;
const UriPath = @import("uri_path.zig").UriPath;

/// Specifies a web request component to be used in a rule match statement or in
/// a logging configuration.
///
/// * In a rule statement, this is the part of the web request that you want WAF
///   to inspect. Include the single
/// `FieldToMatch` type that you want to inspect, with additional specifications
/// as needed, according to the type. You specify a single request component in
/// `FieldToMatch` for each rule statement that requires it. To inspect more
/// than
/// one component of the web request, create a separate rule statement for each
/// component.
///
/// Example JSON for a `QueryString` field to match:
///
/// ` "FieldToMatch": { "QueryString": {} }`
///
/// Example JSON for a `Method` field to match specification:
///
/// ` "FieldToMatch": { "Method": { "Name": "DELETE" } }`
///
/// * In a logging configuration, this is used in the `RedactedFields` property
///   to specify a field to
/// redact from the logging records. For this use case, note the following:
///
/// * Even though all `FieldToMatch` settings
/// are available, the only valid settings for field redaction are `UriPath`,
/// `QueryString`, `SingleHeader`, and `Method`.
///
/// * In this documentation, the descriptions of the individual fields talk
///   about specifying the web request component to inspect,
/// but for field redaction, you are specifying the component type to redact
/// from the logs.
///
/// * If you have request sampling enabled, the redacted fields configuration
///   for logging has no impact on sampling.
/// You can only exclude fields from request sampling by disabling sampling in
/// the web ACL visibility configuration
/// or by configuring data protection for the web ACL.
pub const FieldToMatch = struct {
    /// Inspect all query arguments.
    all_query_arguments: ?AllQueryArguments = null,

    /// Inspect the request body as plain text. The request body immediately follows
    /// the request
    /// headers. This is the part of a request that contains any additional data
    /// that you want to
    /// send to your web server as the HTTP request body, such as data from a form.
    ///
    /// WAF does not support inspecting the entire contents of the web request body
    /// if the body
    /// exceeds the limit for the resource type. When a web request body is larger
    /// than the limit, the underlying host service
    /// only forwards the contents that are within the limit to WAF for inspection.
    ///
    /// * For Application Load Balancer and AppSync, the limit is fixed at 8 KB
    ///   (8,192 bytes).
    ///
    /// * For CloudFront, API Gateway, Amazon Cognito, App Runner, and Verified
    ///   Access, the default limit is 16 KB (16,384 bytes), and
    /// you can increase the limit for each resource type in the web ACL
    /// `AssociationConfig`, for additional processing fees.
    ///
    /// * For Amplify, use the CloudFront limit.
    ///
    /// For information about how to handle oversized
    /// request bodies, see the `Body` object configuration.
    body: ?Body = null,

    /// Inspect the request cookies. You must configure scope and pattern matching
    /// filters in
    /// the `Cookies` object, to define the set of cookies and the parts of the
    /// cookies
    /// that WAF inspects.
    ///
    /// Only the first 8 KB (8192 bytes) of a request's cookies and only the first
    /// 200 cookies
    /// are forwarded to WAF for inspection by the underlying host service. You must
    /// configure how to handle any oversize cookie content in the `Cookies` object.
    /// WAF applies the pattern matching filters to the cookies that it receives
    /// from the
    /// underlying host service.
    cookies: ?Cookies = null,

    /// Inspect a string containing the list of the request's header names, ordered
    /// as they appear in the web request
    /// that WAF receives for inspection.
    /// WAF generates the string and then uses that as the field to match component
    /// in its inspection.
    /// WAF separates the header names in the string using colons and no added
    /// spaces, for example `host:user-agent:accept:authorization:referer`.
    header_order: ?HeaderOrder = null,

    /// Inspect the request headers. You must configure scope and pattern matching
    /// filters in
    /// the `Headers` object, to define the set of headers to and the parts of the
    /// headers that WAF inspects.
    ///
    /// Only the first 8 KB (8192 bytes) of a request's headers and only the first
    /// 200 headers
    /// are forwarded to WAF for inspection by the underlying host service. You must
    /// configure how to handle any oversize header content in the `Headers` object.
    /// WAF applies the pattern matching filters to the headers that it receives
    /// from the
    /// underlying host service.
    headers: ?Headers = null,

    /// Available for use with Amazon CloudFront distributions and Application Load
    /// Balancers. Match against the request's JA3 fingerprint. The JA3 fingerprint
    /// is a 32-character hash derived from the TLS Client Hello of an incoming
    /// request. This fingerprint serves as a unique identifier for the client's TLS
    /// configuration. WAF calculates and logs this fingerprint for each
    /// request that has enough TLS Client Hello information for the calculation.
    /// Almost
    /// all web requests include this information.
    ///
    /// You can use this choice only with a string match `ByteMatchStatement` with
    /// the `PositionalConstraint` set to
    /// `EXACTLY`.
    ///
    /// You can obtain the JA3 fingerprint for client requests from the web ACL
    /// logs.
    /// If WAF is able to calculate the fingerprint, it includes it in the logs.
    /// For information about the logging fields,
    /// see [Log
    /// fields](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the *WAF Developer Guide*.
    ///
    /// Provide the JA3 fingerprint string from the logs in your string match
    /// statement
    /// specification, to match with any future requests that have the same TLS
    /// configuration.
    ja3_fingerprint: ?JA3Fingerprint = null,

    /// Available for use with Amazon CloudFront distributions and Application Load
    /// Balancers. Match against the request's JA4 fingerprint. The JA4 fingerprint
    /// is a 36-character hash derived from the TLS Client Hello of an incoming
    /// request. This fingerprint serves as a unique identifier for the client's TLS
    /// configuration. WAF calculates and logs this fingerprint for each
    /// request that has enough TLS Client Hello information for the calculation.
    /// Almost
    /// all web requests include this information.
    ///
    /// You can use this choice only with a string match `ByteMatchStatement` with
    /// the `PositionalConstraint` set to
    /// `EXACTLY`.
    ///
    /// You can obtain the JA4 fingerprint for client requests from the web ACL
    /// logs.
    /// If WAF is able to calculate the fingerprint, it includes it in the logs.
    /// For information about the logging fields,
    /// see [Log
    /// fields](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the *WAF Developer Guide*.
    ///
    /// Provide the JA4 fingerprint string from the logs in your string match
    /// statement
    /// specification, to match with any future requests that have the same TLS
    /// configuration.
    ja4_fingerprint: ?JA4Fingerprint = null,

    /// Inspect the request body as JSON. The request body immediately follows the
    /// request
    /// headers. This is the part of a request that contains any additional data
    /// that you want to
    /// send to your web server as the HTTP request body, such as data from a form.
    ///
    /// WAF does not support inspecting the entire contents of the web request body
    /// if the body
    /// exceeds the limit for the resource type. When a web request body is larger
    /// than the limit, the underlying host service
    /// only forwards the contents that are within the limit to WAF for inspection.
    ///
    /// * For Application Load Balancer and AppSync, the limit is fixed at 8 KB
    ///   (8,192 bytes).
    ///
    /// * For CloudFront, API Gateway, Amazon Cognito, App Runner, and Verified
    ///   Access, the default limit is 16 KB (16,384 bytes), and
    /// you can increase the limit for each resource type in the web ACL
    /// `AssociationConfig`, for additional processing fees.
    ///
    /// * For Amplify, use the CloudFront limit.
    ///
    /// For information about how to handle oversized
    /// request bodies, see the `JsonBody` object configuration.
    json_body: ?JsonBody = null,

    /// Inspect the HTTP method. The method indicates the type of operation that the
    /// request is
    /// asking the origin to perform.
    method: ?Method = null,

    /// Inspect the query string. This is the part of a URL that appears after a `?`
    /// character, if any.
    query_string: ?QueryString = null,

    /// Inspect a single header. Provide the name of the header to inspect, for
    /// example,
    /// `User-Agent` or `Referer`. This setting isn't case
    /// sensitive.
    ///
    /// Example JSON: `"SingleHeader": { "Name": "haystack" }`
    ///
    /// Alternately, you can filter and inspect all headers with the `Headers`
    /// `FieldToMatch` setting.
    single_header: ?SingleHeader = null,

    /// Inspect a single query argument. Provide the name of the query argument to
    /// inspect, such
    /// as *UserName* or *SalesRegion*. The name can be up to
    /// 30 characters long and isn't case sensitive.
    ///
    /// Example JSON: `"SingleQueryArgument": { "Name": "myArgument" }`
    single_query_argument: ?SingleQueryArgument = null,

    /// Inspect fragments of the request URI. You must configure scope and pattern
    /// matching filters in
    /// the `UriFragment` object, to define the fragment of a URI that WAF inspects.
    ///
    /// Only the first 8 KB (8192 bytes) of a request's URI fragments and only the
    /// first 200 URI fragments
    /// are forwarded to WAF for inspection by the underlying host service. You must
    /// configure how to handle any oversize URI fragment content in the
    /// `UriFragment` object.
    /// WAF applies the pattern matching filters to the cookies that it receives
    /// from the
    /// underlying host service.
    uri_fragment: ?UriFragment = null,

    /// Inspect the request URI path. This is the part of the web request that
    /// identifies a
    /// resource, for example, `/images/daily-ad.jpg`.
    uri_path: ?UriPath = null,

    pub const json_field_names = .{
        .all_query_arguments = "AllQueryArguments",
        .body = "Body",
        .cookies = "Cookies",
        .header_order = "HeaderOrder",
        .headers = "Headers",
        .ja3_fingerprint = "JA3Fingerprint",
        .ja4_fingerprint = "JA4Fingerprint",
        .json_body = "JsonBody",
        .method = "Method",
        .query_string = "QueryString",
        .single_header = "SingleHeader",
        .single_query_argument = "SingleQueryArgument",
        .uri_fragment = "UriFragment",
        .uri_path = "UriPath",
    };
};
