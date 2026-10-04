const aws = @import("aws");

const MethodType = @import("method_type.zig").MethodType;
const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// The configuration for an `AWS_SERVICE_REQUEST` function. Contains the target
/// service, target Region, and request parameters that the function uses to
/// call an AWS service API. For more information, see
/// [AWS_SERVICE_REQUEST](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-types-aws-service-request.html) in the *MediaTailor User Guide*.
pub const AwsServiceRequestConfiguration = struct {
    /// An expression that evaluates to the request body for the AWS service API
    /// call. The body must conform to the input format that the target service
    /// operation expects. Applies only when the target operation accepts a request
    /// body. The maximum size after evaluation is 64 KB.
    body: ?[]const u8 = null,

    /// A map of HTTP header names to expression values. MediaTailor evaluates each
    /// header value expression at runtime and includes the result in the outbound
    /// request to the AWS service. Use this to pass any headers required by the
    /// target service operation. You can include a maximum of 50 headers.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// Specifies how the function sends the request to the target service. The
    /// value must match what the target service operation requires. Valid values:
    ///
    /// * `GET` – Retrieves data from the target service.
    /// * `POST` – Submits a request body to the target service.
    method_type: MethodType,

    /// A map of output bindings. Each key is a namespaced output path, such as
    /// `player_params.device_type`. Each value is an expression that MediaTailor
    /// evaluates at runtime and can reference the `response` object from the target
    /// service. For more information, see [JSONata expression
    /// reference](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-jsonata.html) in the *MediaTailor User Guide*.
    output: ?[]const aws.map.StringMapEntry = null,

    /// The maximum time, in milliseconds, that MediaTailor waits for a response
    /// from the AWS service. If the call exceeds this timeout, MediaTailor sets the
    /// response status code to `null` and proceeds with output expression
    /// evaluation. Valid values: `100` to `2000`.
    request_timeout_milliseconds: i32,

    /// The expression language used to evaluate expressions in the function
    /// configuration. The only supported value is `JSONata`.
    runtime: RuntimeType,

    /// The AWS Region for the target service. Specify a static Region code (for
    /// example, `us-east-1`) or a JSONata expression that resolves to a Region code
    /// at runtime (for example, `{%inference.region%}`).
    target_region: []const u8,

    /// The AWS service to call. Valid value: `elemental-inference` (AWS Elemental
    /// Inference).
    target_service: []const u8,

    /// An expression that evaluates to the endpoint URL for the target AWS service
    /// API operation. Use `{%...%}` delimiters for dynamic expressions. The URL
    /// must correspond to a valid endpoint for the service specified in
    /// `TargetService`. The maximum length after evaluation is 2,048 characters.
    url: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .headers = "Headers",
        .method_type = "MethodType",
        .output = "Output",
        .request_timeout_milliseconds = "RequestTimeoutMilliseconds",
        .runtime = "Runtime",
        .target_region = "TargetRegion",
        .target_service = "TargetService",
        .url = "Url",
    };
};
