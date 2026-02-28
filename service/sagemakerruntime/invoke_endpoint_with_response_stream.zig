const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeEndpointWithResponseStreamInput = struct {
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

    /// The name of the endpoint that you specified when you created the endpoint
    /// using the
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/API_CreateEndpoint.html) API.
    endpoint_name: []const u8,

    /// If the endpoint hosts one or more inference components, this parameter
    /// specifies the
    /// name of inference component to invoke for a streaming response.
    inference_component_name: ?[]const u8 = null,

    /// An identifier that you assign to your request.
    inference_id: ?[]const u8 = null,

    /// The ID of a stateful session to handle your request.
    ///
    /// You can't create a stateful session by using the
    /// `InvokeEndpointWithResponseStream` action. Instead, you can create one by
    /// using the `
    /// InvokeEndpoint
    /// ` action. In your request, you
    /// specify `NEW_SESSION` for the `SessionId` request parameter. The
    /// response to that request provides the session ID for the `NewSessionId`
    /// response parameter.
    session_id: ?[]const u8 = null,

    /// If the endpoint hosts multiple containers and is configured to use direct
    /// invocation,
    /// this parameter specifies the host name of the container to invoke.
    target_container_hostname: ?[]const u8 = null,

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
        .endpoint_name = "EndpointName",
        .inference_component_name = "InferenceComponentName",
        .inference_id = "InferenceId",
        .session_id = "SessionId",
        .target_container_hostname = "TargetContainerHostname",
        .target_variant = "TargetVariant",
    };
};

pub const InvokeEndpointWithResponseStreamOutput = struct {
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

    event_reader: aws.event_stream_reader.EventStreamReader = undefined,
    _stream_body: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *InvokeEndpointWithResponseStreamOutput) void {
        self.event_reader.deinit();
        self._stream_body.deinit();
    }

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .invoked_production_variant = "InvokedProductionVariant",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeEndpointWithResponseStreamInput, options: Options) !InvokeEndpointWithResponseStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemakerruntime");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const event_reader = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body.reader());
    return .{ .event_reader = event_reader, ._stream_body = stream_resp.body };
}

fn serializeRequest(alloc: std.mem.Allocator, input: InvokeEndpointWithResponseStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakerruntime", "SageMaker Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/endpoints/");
    try path_buf.appendSlice(alloc, input.endpoint_name);
    try path_buf.appendSlice(alloc, "/invocations-response-stream");
    const path = try path_buf.toOwnedSlice(alloc);

    const body = input.body;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Accept", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(alloc, "Content-Type", v);
    }
    if (input.custom_attributes) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Custom-Attributes", v);
    }
    if (input.inference_component_name) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Inference-Component", v);
    }
    if (input.inference_id) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Inference-Id", v);
    }
    if (input.session_id) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Session-Id", v);
    }
    if (input.target_container_hostname) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Target-Container-Hostname", v);
    }
    if (input.target_variant) |v| {
        try request.headers.put(alloc, "X-Amzn-SageMaker-Target-Variant", v);
    }

    return request;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
