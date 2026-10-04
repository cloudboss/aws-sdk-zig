const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandParameterValue = @import("command_parameter_value.zig").CommandParameterValue;

pub const StartCommandExecutionInput = struct {
    /// The client token is used to implement idempotency. It ensures that the
    /// request completes
    /// no more than one time. If you retry a request with the same token and the
    /// same parameters,
    /// the request will complete successfully. However, if you retry the request
    /// using the same
    /// token but different parameters, an HTTP 409 conflict occurs. If you omit
    /// this value, Amazon Web Services
    /// SDKs will automatically generate a unique client request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the command. For example,
    /// `arn:aws:iot:::command/`
    command_arn: []const u8,

    /// Specifies the amount of time in second the device has to finish the command
    /// execution. A
    /// timer is started as soon as the command execution is created. If the command
    /// execution
    /// status is not set to another terminal state before the timer expires, it
    /// will automatically
    /// update to `TIMED_OUT`.
    execution_timeout_seconds: ?i64 = null,

    /// A list of parameters that are required by the `StartCommandExecution` API
    /// when performing the command on a device.
    parameters: ?[]const aws.map.MapEntry(CommandParameterValue) = null,

    /// The Amazon Resource Number (ARN) of the device where the command execution
    /// is
    /// occurring.
    target_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .command_arn = "commandArn",
        .execution_timeout_seconds = "executionTimeoutSeconds",
        .parameters = "parameters",
        .target_arn = "targetArn",
    };
};

pub const StartCommandExecutionOutput = struct {
    /// A unique identifier for the command execution.
    execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_id = "executionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCommandExecutionInput, options: CallOptions) !StartCommandExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot-jobs-data", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCommandExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.jobs.iot", "IoT Jobs Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/command-executions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"commandArn\":");
    try aws.json.writeValue(@TypeOf(input.command_arn), input.command_arn, allocator, &body_buf);
    has_prev = true;
    if (input.execution_timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionTimeoutSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetArn\":");
    try aws.json.writeValue(@TypeOf(input.target_arn), input.target_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCommandExecutionOutput {
    const result: StartCommandExecutionOutput = try aws.json.parseJsonObject(
        StartCommandExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
