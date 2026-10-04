const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CancellationStatus = @import("cancellation_status.zig").CancellationStatus;

pub const CancelQuantumTaskInput = struct {
    /// The client token associated with the cancellation request.
    client_token: []const u8,

    /// The ARN of the quantum task to cancel.
    quantum_task_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .quantum_task_arn = "quantumTaskArn",
    };
};

pub const CancelQuantumTaskOutput = struct {
    /// The status of the quantum task.
    cancellation_status: CancellationStatus,

    /// The ARN of the quantum task.
    quantum_task_arn: []const u8,

    pub const json_field_names = .{
        .cancellation_status = "cancellationStatus",
        .quantum_task_arn = "quantumTaskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelQuantumTaskInput, options: CallOptions) !CancelQuantumTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "braket", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelQuantumTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/quantum-task/");
    try path_buf.appendSlice(allocator, input.quantum_task_arn);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelQuantumTaskOutput {
    var result: CancelQuantumTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CancelQuantumTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
