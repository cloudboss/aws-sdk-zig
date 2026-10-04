const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResponseStreamingInvocationType = @import("response_streaming_invocation_type.zig").ResponseStreamingInvocationType;
const LogType = @import("log_type.zig").LogType;
const InvokeWithResponseStreamResponseEvent = @import("invoke_with_response_stream_response_event.zig").InvokeWithResponseStreamResponseEvent;

pub const InvokeWithResponseStreamInput = struct {
    /// Up to 3,583 bytes of base64-encoded data about the invoking client to pass
    /// to the function in the context object.
    client_context: ?[]const u8 = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Use one of the following options:
    ///
    /// * `RequestResponse` (default) – Invoke the function synchronously. Keep the
    ///   connection open until the function returns a response or times out. The
    ///   API operation response includes the function response and additional data.
    /// * `DryRun` – Validate parameter values and verify that the IAM user or role
    ///   has permission to invoke the function.
    invocation_type: ?ResponseStreamingInvocationType = null,

    /// Set to `Tail` to include the execution log in the response. Applies to
    /// synchronously invoked functions only.
    log_type: ?LogType = null,

    /// The JSON that you want to provide to your Lambda function as input.
    ///
    /// You can enter the JSON directly. For example, `--payload '{ "key": "value"
    /// }'`. You can also specify a file path. For example, `--payload
    /// file://payload.json`.
    payload: ?[]const u8 = null,

    /// The alias name.
    qualifier: ?[]const u8 = null,

    /// The identifier of the tenant in a multi-tenant Lambda function.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_context = "ClientContext",
        .function_name = "FunctionName",
        .invocation_type = "InvocationType",
        .log_type = "LogType",
        .payload = "Payload",
        .qualifier = "Qualifier",
        .tenant_id = "TenantId",
    };
};

pub const InvokeWithResponseStreamOutput = struct {
    /// The version of the function that executed. When you invoke a function with
    /// an alias, this indicates which version the alias resolved to.
    executed_version: ?[]const u8 = null,

    /// The type of data the stream is returning.
    response_stream_content_type: ?[]const u8 = null,

    /// For a successful request, the HTTP status code is in the 200 range. For the
    /// `RequestResponse` invocation type, this status code is 200. For the `DryRun`
    /// invocation type, this status code is 204.
    status_code: ?i32 = null,

    event_stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeWithResponseStreamOutput) void {
        self.event_stream.deinit();
    }

    pub const json_field_names = .{
        .event_stream = "EventStream",
        .executed_version = "ExecutedVersion",
        .response_stream_content_type = "ResponseStreamContentType",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeWithResponseStreamInput, options: CallOptions) !InvokeWithResponseStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeWithResponseStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-11-15/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/response-streaming-invocations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.payload orelse "";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_context) |v| {
        try request.headers.put(allocator, "X-Amz-Client-Context", v);
    }
    if (input.invocation_type) |v| {
        try request.headers.put(allocator, "X-Amz-Invocation-Type", v.wireName());
    }
    if (input.log_type) |v| {
        try request.headers.put(allocator, "X-Amz-Log-Type", v.wireName());
    }
    if (input.tenant_id) |v| {
        try request.headers.put(allocator, "X-Amz-Tenant-Id", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !InvokeWithResponseStreamOutput {
    var result: InvokeWithResponseStreamOutput = .{};
    errdefer {
        if (result.executed_version) |value| allocator.free(value);
        if (result.response_stream_content_type) |value| allocator.free(value);
    }
    result.status_code = @intCast(stream_resp.status);
    if (stream_resp.headers.get("x-amz-executed-version")) |value| {
        result.executed_version = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.response_stream_content_type = try allocator.dupe(u8, value);
    }
    result.event_stream = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
