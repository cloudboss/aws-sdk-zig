const aws = @import("aws");

const MethodType = @import("method_type.zig").MethodType;
const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// -- Function Configuration DataStructure
pub const HttpRequestConfiguration = struct {
    /// An expression that evaluates to the request body. Used with `POST` requests.
    /// The maximum size after evaluation is 64 KB.
    body: ?[]const u8 = null,

    /// A map of HTTP header names to expression values. MediaTailor evaluates each
    /// header value expression at runtime and includes the result in the outbound
    /// HTTP request. Maximum 50 headers.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The HTTP method for the request. Valid values: `GET` and `POST`.
    method_type: MethodType,

    /// A map of output bindings. Each key is a namespaced output path (such as
    /// `player_params.device_type` or `temp.identity`), and each value is an
    /// expression that MediaTailor evaluates at runtime. Output expressions in an
    /// `HTTP_REQUEST` function can reference the `response` object returned by the
    /// HTTP call. For more information about expression syntax, see [JSONata
    /// expression
    /// reference](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-jsonata.html) in the *MediaTailor User Guide*.
    output: ?[]const aws.map.StringMapEntry = null,

    /// The maximum time, in milliseconds, that MediaTailor waits for a response
    /// from the external service. If the call exceeds this timeout, MediaTailor
    /// sets the response status code to `null` and proceeds with output expression
    /// evaluation. Valid values: `100` to `2000`.
    request_timeout_milliseconds: i32,

    /// The expression language used to evaluate expressions in the function
    /// configuration. Set this to `JSONata`.
    runtime: RuntimeType,

    /// An expression that evaluates to the request URL. Use `{%...%}` delimiters
    /// for dynamic expressions. The maximum length after evaluation is 2,048
    /// characters.
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
