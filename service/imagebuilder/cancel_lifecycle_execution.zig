const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelLifecycleExecutionInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// Identifies the specific runtime instance of the image lifecycle to cancel.
    lifecycle_execution_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .lifecycle_execution_id = "lifecycleExecutionId",
    };
};

pub const CancelLifecycleExecutionOutput = struct {
    /// The unique identifier for the image lifecycle runtime instance that was
    /// canceled.
    lifecycle_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_execution_id = "lifecycleExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelLifecycleExecutionInput, options: CallOptions) !CancelLifecycleExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelLifecycleExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CancelLifecycleExecution";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lifecycleExecutionId\":");
    try aws.json.writeValue(@TypeOf(input.lifecycle_execution_id), input.lifecycle_execution_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelLifecycleExecutionOutput {
    var result: CancelLifecycleExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelLifecycleExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
