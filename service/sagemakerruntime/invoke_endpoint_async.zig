const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const InvokeEndpointAsyncInput = struct {
    /// The desired MIME type of the inference response from the model container.
    accept: ?[]const u8 = null,

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

    /// The identifier for the inference request. Amazon SageMaker AI will generate
    /// an
    /// identifier for you if none is specified.
    inference_id: ?[]const u8 = null,

    /// The Amazon S3 URI where the inference request payload is stored.
    input_location: []const u8,

    /// Maximum amount of time in seconds a request can be processed before it is
    /// marked as
    /// expired. The default is 15 minutes, or 900 seconds.
    invocation_timeout_seconds: ?i32 = null,

    /// Maximum age in seconds a request can be in the queue before it is marked as
    /// expired.
    /// The default is 6 hours, or 21,600 seconds.
    request_ttl_seconds: ?i32 = null,

    pub const json_field_names = .{
        .accept = "Accept",
        .content_type = "ContentType",
        .custom_attributes = "CustomAttributes",
        .endpoint_name = "EndpointName",
        .inference_id = "InferenceId",
        .input_location = "InputLocation",
        .invocation_timeout_seconds = "InvocationTimeoutSeconds",
        .request_ttl_seconds = "RequestTTLSeconds",
    };
};

pub const InvokeEndpointAsyncOutput = struct {
    /// The Amazon S3 URI where the inference failure response payload is
    /// stored.
    failure_location: ?[]const u8 = null,

    /// Identifier for an inference request. This will be the same as the
    /// `InferenceId` specified in the input. Amazon SageMaker AI will generate
    /// an identifier for you if you do not specify one.
    inference_id: ?[]const u8 = null,

    /// The Amazon S3 URI where the inference response payload is stored.
    output_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_location = "FailureLocation",
        .inference_id = "InferenceId",
        .output_location = "OutputLocation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeEndpointAsyncInput, options: CallOptions) !InvokeEndpointAsyncOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeEndpointAsyncInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("runtime.sagemaker", "SageMaker Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
    try path_buf.appendSlice(allocator, "/async-invocations");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Accept", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Content-Type", v);
    }
    if (input.custom_attributes) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Custom-Attributes", v);
    }
    if (input.inference_id) |v| {
        try request.headers.put(allocator, "X-Amzn-SageMaker-Inference-Id", v);
    }
    try request.headers.put(allocator, "X-Amzn-SageMaker-InputLocation", input.input_location);
    if (input.invocation_timeout_seconds) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "X-Amzn-SageMaker-InvocationTimeoutSeconds", num_str);
        }
    }
    if (input.request_ttl_seconds) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "X-Amzn-SageMaker-RequestTTLSeconds", num_str);
        }
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeEndpointAsyncOutput {
    var result: InvokeEndpointAsyncOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InvokeEndpointAsyncOutput, body, allocator);
    }
    _ = status;
    if (headers.get("x-amzn-sagemaker-failurelocation")) |value| {
        result.failure_location = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amzn-sagemaker-outputlocation")) |value| {
        result.output_location = try allocator.dupe(u8, value);
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
