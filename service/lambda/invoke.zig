const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvocationType = @import("invocation_type.zig").InvocationType;
const LogType = @import("log_type.zig").LogType;

pub const InvokeInput = struct {
    /// Up to 3,583 bytes of base64-encoded data about the invoking client to pass
    /// to the function in the context object. Lambda passes the `ClientContext`
    /// object to your function for synchronous invocations only.
    client_context: ?[]const u8 = null,

    /// A unique name for the durable execution. If you invoke a durable function
    /// using a name that already exists with the same payload, Lambda returns the
    /// existing execution instead of creating a duplicate. If the payload differs,
    /// Lambda returns a `DurableExecutionAlreadyStartedException` error.
    ///
    /// If not specified, Lambda generates a unique identifier automatically. For
    /// more information, see [Execution
    /// names](https://docs.aws.amazon.com/lambda/latest/dg/durable-execution-idempotency.html#durable-idempotency-execution-names).
    durable_execution_name: ?[]const u8 = null,

    /// The name or ARN of the Lambda function, version, or alias. **Name formats**
    ///
    /// * **Function name** – `my-function` (name-only), `my-function:v1` (with
    ///   alias).
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// You can append a version number or alias to any of the formats. The length
    /// constraint applies only to the full ARN. If you specify only the function
    /// name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Choose from the following options.
    ///
    /// * `RequestResponse` (default) – Invoke the function synchronously. Keep the
    ///   connection open until the function returns a response or times out. The
    ///   API response includes the function response and additional data.
    /// * `Event` – Invoke the function asynchronously. Send events that fail
    ///   multiple times to the function's dead-letter queue (if one is configured).
    ///   The API response only includes a status code.
    /// * `DryRun` – Validate parameter values and verify that the user or role has
    ///   permission to invoke the function.
    invocation_type: ?InvocationType = null,

    /// Set to `Tail` to include the execution log in the response. Applies to
    /// synchronously invoked functions only.
    log_type: ?LogType = null,

    /// The JSON that you want to provide to your Lambda function as input. The
    /// maximum payload size is 6 MB for synchronous invocations and 1 MB for
    /// asynchronous invocations.
    ///
    /// You can enter the JSON directly. For example, `--payload '{ "key": "value"
    /// }'`. You can also specify a file path. For example, `--payload
    /// file://payload.json`.
    payload: ?[]const u8 = null,

    /// Specify a version or alias to invoke a published version of the function.
    qualifier: ?[]const u8 = null,

    /// The identifier of the tenant in a multi-tenant Lambda function.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_context = "ClientContext",
        .durable_execution_name = "DurableExecutionName",
        .function_name = "FunctionName",
        .invocation_type = "InvocationType",
        .log_type = "LogType",
        .payload = "Payload",
        .qualifier = "Qualifier",
        .tenant_id = "TenantId",
    };
};

pub const InvokeOutput = struct {
    /// The ARN of the durable execution that was started. This is returned when
    /// invoking a durable function and provides a unique identifier for tracking
    /// the execution.
    durable_execution_arn: ?[]const u8 = null,

    /// The version of the function that executed. When you invoke a function with
    /// an alias, this indicates which version the alias resolved to.
    executed_version: ?[]const u8 = null,

    /// If present, indicates that an error occurred during function execution.
    /// Details about the error are included in the response payload.
    function_error: ?[]const u8 = null,

    /// The last 4 KB of the execution log, which is base64-encoded.
    log_result: ?[]const u8 = null,

    /// The response from the function, or an error object.
    payload: ?[]const u8 = null,

    /// The HTTP status code is in the 200 range for a successful request. For the
    /// `RequestResponse` invocation type, this status code is 200. For the `Event`
    /// invocation type, this status code is 202. For the `DryRun` invocation type,
    /// the status code is 204.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
        .executed_version = "ExecutedVersion",
        .function_error = "FunctionError",
        .log_result = "LogResult",
        .payload = "Payload",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeInput, options: CallOptions) !InvokeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/invocations");
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
    if (input.durable_execution_name) |v| {
        try request.headers.put(allocator, "X-Amz-Durable-Execution-Name", v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeOutput {
    var result: InvokeOutput = .{};
    errdefer {
        if (result.durable_execution_arn) |value| allocator.free(value);
        if (result.executed_version) |value| allocator.free(value);
        if (result.function_error) |value| allocator.free(value);
        if (result.log_result) |value| allocator.free(value);
        if (result.payload) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.payload = try allocator.dupe(u8, body);
    }
    result.status_code = @intCast(status);
    if (headers.get("x-amz-durable-execution-arn")) |value| {
        result.durable_execution_arn = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-executed-version")) |value| {
        result.executed_version = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-function-error")) |value| {
        result.function_error = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-log-result")) |value| {
        result.log_result = try allocator.dupe(u8, value);
    }

    return result;
}
