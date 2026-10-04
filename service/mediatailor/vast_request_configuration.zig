const aws = @import("aws");

const MethodType = @import("method_type.zig").MethodType;
const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// The configuration for a `VAST_REQUEST` function. Specifies the HTTP method,
/// URL, headers, body, timeout, and output expressions for a request to a VAST
/// endpoint. MediaTailor parses the response as VAST and resolves wrapper
/// redirects, then makes the parsed ads available to the function's output
/// expressions. For more information, see [Function types and
/// composition](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-types.html) in the *MediaTailor User Guide*.
pub const VastRequestConfiguration = struct {
    /// An expression that evaluates to the request body, for example to send an
    /// OpenRTB bid request. The expression can be up to 100,000 characters, and the
    /// body after evaluation can be up to 64 KB.
    body: ?[]const u8 = null,

    /// A map of HTTP header names to expression values. MediaTailor evaluates each
    /// header value expression at runtime and includes the result in the outbound
    /// request. Headers beginning with `X-Amz-` are reserved by the service, and
    /// method override headers are not allowed.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The HTTP method for the request to the VAST endpoint. Valid values: `GET`
    /// and `POST`. Use `POST` to send a bid request body, such as an OpenRTB
    /// payload.
    method_type: MethodType,

    /// A map of output bindings. Each key is a namespaced output path (such as
    /// `temp.wrappedAds`), and each value is an expression that MediaTailor
    /// evaluates at runtime. Output expressions in a `VAST_REQUEST` function can
    /// reference the `response` object, which exposes `response.parsedAds` — the
    /// ads parsed from the VAST response after schema validation and wrapper
    /// resolution — and `response.statusCode`. For more information about
    /// expression syntax, see [JSONata expression
    /// reference](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-jsonata.html) in the *MediaTailor User Guide*.
    output: ?[]const aws.map.StringMapEntry = null,

    /// The maximum time, in milliseconds, that MediaTailor waits for a response
    /// from the VAST endpoint. The timeout covers the entire response, including
    /// any wrapper redirects that MediaTailor follows. If the call exceeds this
    /// timeout, MediaTailor proceeds with an empty ad list and continues output
    /// expression evaluation. Valid values: `100` to `2000`.
    request_timeout_milliseconds: i32,

    /// The expression language used to evaluate expressions in the function
    /// configuration. Set this to `JSONata`.
    runtime: RuntimeType,

    /// An expression that evaluates to the VAST endpoint URL. Use `{%...%}`
    /// delimiters for dynamic expressions. A literal value must be an `https://`
    /// URL. The expression can be up to 25,000 characters, and the URL after
    /// evaluation can be up to 2,048 characters.
    url: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .headers = "Headers",
        .method_type = "MethodType",
        .output = "Output",
        .request_timeout_milliseconds = "RequestTimeoutMilliseconds",
        .runtime = "Runtime",
        .url = "Url",
    };
};
