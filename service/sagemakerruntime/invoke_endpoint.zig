const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const InvokeEndpointInput = struct {
    /// The desired MIME type of the inference response from the model container.
    accept: ?[]const u8 = null,

    /// Provides input data, in the format specified in the `ContentType`
    /// request header. Amazon SageMaker AI passes all of the data in the body to
    /// the model.
    ///
    /// For information about the format of the request body, see [Common Data
    /// Formats-Inference](https://docs.aws.amazon.com/sagemaker/latest/dg/cdf-inference.html).
    body: []const u8,

    /// The MIME type of the input data in the request body.
    content_type: ?[]const u8 = null,

    /// Provides additional information about a request for an inference submitted
    /// to a model
    /// hosted at an Amazon SageMaker AI endpoint. The information is an opaque
    /// value that is forwarded
    /// verbatim. You could use this value, for example, to provide an ID that you
    /// can use to
    /// track a request or to provide other metadata that a service endpoint was
    /// programmed to
    /// process. The value must consist of no more than 1024 visible US-ASCII
    /// characters as
    /// specified in [Section 3.3.6. Field Value
    /// Components](https://datatracker.ietf.org/doc/html/rfc7230#section-3.2.6) of
    /// the Hypertext Transfer Protocol
    /// (HTTP/1.1).
    ///
    /// The code in your model is responsible for setting or updating any custom
    /// attributes in
    /// the response. If your code does not set this value in the response, an empty
    /// value is
    /// returned. For example, if a custom attribute represents the trace ID, your
    /// model can
    /// prepend the custom attribute with `Trace ID:` in your post-processing
    /// function.
    ///
    /// This feature is currently supported in the Amazon Web Services SDKs but not
    /// in the Amazon SageMaker AI
    /// Python SDK.
    custom_attributes: ?[]const u8 = null,

    /// An optional JMESPath expression used to override the `EnableExplanations`
    /// parameter of the `ClarifyExplainerConfig` API. See the
    /// [EnableExplanations](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-online-explainability-create-endpoint.html#clarify-online-explainability-create-endpoint-enable) section in the developer guide for more information.
    enable_explanations: ?[]const u8 = null,

    /// The name of the endpoint that you specified when you created the endpoint
    /// using the
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/API_CreateEndpoint.html) API.
    endpoint_name: []const u8,

    /// If the endpoint hosts one or more inference components, this parameter
    /// specifies the
    /// name of inference component to invoke.
    inference_component_name: ?[]const u8 = null,

    /// If you provide a value, it is added to the captured data when you enable
    /// data capture
    /// on the endpoint. For information about data capture, see [Capture
    /// Data](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor-data-capture.html).
    inference_id: ?[]const u8 = null,

    /// Creates a stateful session or identifies an existing one. You can do one of
    /// the
    /// following:
    ///
    /// * Create a stateful session by specifying the value
    /// `NEW_SESSION`.
    ///
    /// * Send your request to an existing stateful session by specifying the ID of
    ///   that
    /// session.
    ///
    /// With a stateful session, you can send multiple requests to a stateful model.
    /// When you
    /// create a session with a stateful model, the model must create the session ID
    /// and set the
    /// expiration time. The model must also provide that information in the
    /// response to your
    /// request. You can get the ID and timestamp from the `NewSessionId` response
    /// parameter. For any subsequent request where you specify that session ID,
    /// SageMaker AI routes the request to the same instance that supports the
    /// session.
    session_id: ?[]const u8 = null,

    /// If the endpoint hosts multiple containers and is configured to use direct
    /// invocation,
    /// this parameter specifies the host name of the container to invoke.
    target_container_hostname: ?[]const u8 = null,

    /// The model to request for inference when invoking a multi-model endpoint.
    target_model: ?[]const u8 = null,

    /// Specify the production variant to send the inference request to when
    /// invoking an
    /// endpoint that is running two or more variants. Note that this parameter
    /// overrides the
    /// default behavior for the endpoint, which is to distribute the invocation
    /// traffic based
    /// on the variant weights.
    ///
    /// For information about how to use variant targeting to perform a/b testing,
    /// see [Test models in
    /// production](https://docs.aws.amazon.com/sagemaker/latest/dg/model-ab-testing.html)
    target_variant: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept = "Accept",
        .body = "Body",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .enable_explanations = "EnableExplanations",
        .endpoint_name = "EndpointName",
        .inference_component_name = "InferenceComponentName",
        .inference_id = "InferenceId",
        .session_id = "SessionId",
        .target_container_hostname = "TargetContainerHostname",
        .target_model = "TargetModel",
        .target_variant = "TargetVariant",
    };
};

pub const InvokeEndpointOutput = struct {
    /// Includes the inference provided by the model.
    ///
    /// For information about the format of the response body, see [Common Data
    /// Formats-Inference](https://docs.aws.amazon.com/sagemaker/latest/dg/cdf-inference.html).
    ///
    /// If the explainer is activated, the body includes the explanations provided
    /// by the
    /// model. For more information, see the **Response section**
    /// under [Invoke the
    /// Endpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-online-explainability-invoke-endpoint.html#clarify-online-explainability-response) in the Developer Guide.
    body: []const u8,

    /// If you closed a stateful session with your request, the ID of that session.
    closed_session_id: ?[]const u8 = null,

    /// The MIME type of the inference returned from the model container.
    content_type: ?[]const u8 = null,

    /// Provides additional information in the response about the inference returned
    /// by a
    /// model hosted at an Amazon SageMaker AI endpoint. The information is an
    /// opaque value that is
    /// forwarded verbatim. You could use this value, for example, to return an ID
    /// received in
    /// the `CustomAttributes` header of a request or other metadata that a service
    /// endpoint was programmed to produce. The value must consist of no more than
    /// 1024 visible
    /// US-ASCII characters as specified in [Section 3.3.6. Field Value
    /// Components](https://tools.ietf.org/html/rfc7230#section-3.2.6) of the
    /// Hypertext Transfer Protocol (HTTP/1.1). If the customer
    /// wants the custom attribute returned, the model must set the custom attribute
    /// to be
    /// included on the way back.
    ///
    /// The code in your model is responsible for setting or updating any custom
    /// attributes in
    /// the response. If your code does not set this value in the response, an empty
    /// value is
    /// returned. For example, if a custom attribute represents the trace ID, your
    /// model can
    /// prepend the custom attribute with `Trace ID:` in your post-processing
    /// function.
    ///
    /// This feature is currently supported in the Amazon Web Services SDKs but not
    /// in the Amazon SageMaker AI
    /// Python SDK.
    custom_attributes: ?[]const u8 = null,

    /// Identifies the production variant that was invoked.
    invoked_production_variant: ?[]const u8 = null,

    /// If you created a stateful session with your request, the ID and expiration
    /// time that
    /// the model assigns to that session.
    new_session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .closed_session_id = "ClosedSessionId",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .invoked_production_variant = "InvokedProductionVariant",
        .new_session_id = "NewSessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeEndpointInput, options: CallOptions) !InvokeEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("runtime.sagemaker", "SageMaker Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
    try path_buf.appendSlice(allocator, "/invocations");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.body;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(allocator, "Accept", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v);
    }
    if (input.custom_attributes) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Custom-Attributes", v);
    }
    if (input.enable_explanations) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Enable-Explanations", v);
    }
    if (input.inference_component_name) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Inference-Component", v);
    }
    if (input.inference_id) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Inference-Id", v);
    }
    if (input.session_id) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Session-Id", v);
    }
    if (input.target_container_hostname) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Target-Container-Hostname", v);
    }
    if (input.target_model) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Target-Model", v);
    }
    if (input.target_variant) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Target-Variant", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeEndpointOutput {
    var result: InvokeEndpointOutput = .{};
    result.body = try allocator.dupe(u8, body);
    _ = status;
    if (headers.get("x-amzn-sagemaker-closed-session-id")) |value| {
        result.closed_session_id = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amzn-sagemaker-custom-attributes")) |value| {
        result.custom_attributes = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amzn-invoked-production-variant")) |value| {
        result.invoked_production_variant = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amzn-sagemaker-new-session-id")) |value| {
        result.new_session_id = try allocator.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalDependencyException")) {
        return .{ .arena = arena, .kind = .{ .internal_dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalStreamFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_stream_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelError")) {
        return .{ .arena = arena, .kind = .{ .model_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelStreamError")) {
        return .{ .arena = arena, .kind = .{ .model_stream_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
