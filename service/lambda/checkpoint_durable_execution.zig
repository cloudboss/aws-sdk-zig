const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperationUpdate = @import("operation_update.zig").OperationUpdate;
const CheckpointUpdatedExecutionState = @import("checkpoint_updated_execution_state.zig").CheckpointUpdatedExecutionState;

pub const CheckpointDurableExecutionInput = struct {
    /// A unique token that identifies the current checkpoint state. This token is
    /// provided by the Lambda runtime and must be used to ensure checkpoints are
    /// applied in the correct order. Each checkpoint operation consumes this token
    /// and returns a new one.
    checkpoint_token: []const u8,

    /// An optional idempotency token to ensure that duplicate checkpoint requests
    /// are handled correctly. If provided, Lambda uses this token to detect and
    /// handle duplicate requests within a 15-minute window.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    /// An array of state updates to apply during this checkpoint. Each update
    /// represents a change to the execution state, such as completing a step,
    /// starting a callback, or scheduling a timer. Updates are applied atomically
    /// as part of the checkpoint operation.
    updates: ?[]const OperationUpdate = null,

    pub const json_field_names = .{
        .checkpoint_token = "CheckpointToken",
        .client_token = "ClientToken",
        .durable_execution_arn = "DurableExecutionArn",
        .updates = "Updates",
    };
};

pub const CheckpointDurableExecutionOutput = struct {
    /// A new checkpoint token to use for the next checkpoint operation. This token
    /// replaces the one provided in the request and must be used for subsequent
    /// checkpoints to maintain proper ordering.
    checkpoint_token: ?[]const u8 = null,

    /// Updated execution state information that includes any changes that occurred
    /// since the last checkpoint, such as completed callbacks or expired timers.
    /// This allows the SDK to update its internal state during replay.
    new_execution_state: ?CheckpointUpdatedExecutionState = null,

    pub const json_field_names = .{
        .checkpoint_token = "CheckpointToken",
        .new_execution_state = "NewExecutionState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckpointDurableExecutionInput, options: CallOptions) !CheckpointDurableExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckpointDurableExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-executions/");
    try path_buf.appendSlice(allocator, input.durable_execution_arn);
    try path_buf.appendSlice(allocator, "/checkpoint");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CheckpointToken\":");
    try aws.json.writeValue(@TypeOf(input.checkpoint_token), input.checkpoint_token, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.updates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Updates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckpointDurableExecutionOutput {
    const result: CheckpointDurableExecutionOutput = try aws.json.parseJsonObject(
        CheckpointDurableExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
