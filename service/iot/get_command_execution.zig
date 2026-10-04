const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandParameterValue = @import("command_parameter_value.zig").CommandParameterValue;
const CommandExecutionResult = @import("command_execution_result.zig").CommandExecutionResult;
const CommandExecutionStatus = @import("command_execution_status.zig").CommandExecutionStatus;
const StatusReason = @import("status_reason.zig").StatusReason;

pub const GetCommandExecutionInput = struct {
    /// The unique identifier for the command execution. This information is
    /// returned as a
    /// response of the `StartCommandExecution` API request.
    execution_id: []const u8,

    /// Can be used to specify whether to include the result of the command
    /// execution
    /// in the `GetCommandExecution` API response. Your device can use this
    /// field to provide additional information about the command execution. You
    /// only
    /// need to specify this field when using the `AWS-IoT` namespace.
    include_result: ?bool = null,

    /// The Amazon Resource Number (ARN) of the device on which the command
    /// execution is being
    /// performed.
    target_arn: []const u8,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .include_result = "includeResult",
        .target_arn = "targetArn",
    };
};

pub const GetCommandExecutionOutput = struct {
    /// The Amazon Resource Number (ARN) of the command. For example,
    /// ``arn:aws:iot:::command/
    command_arn: ?[]const u8 = null,

    /// The timestamp, when the command execution was completed.
    completed_at: ?i64 = null,

    /// The timestamp, when the command execution was created.
    created_at: ?i64 = null,

    /// The unique identifier of the command execution.
    execution_id: ?[]const u8 = null,

    /// Specifies the amount of time in seconds that the device can take to finish a
    /// command
    /// execution. A timer starts when the command execution is created. If the
    /// command
    /// execution status is not set to another terminal state before the timer
    /// expires, it will
    /// automatically update to `TIMED_OUT`.
    execution_timeout_seconds: ?i64 = null,

    /// The timestamp, when the command execution was last updated.
    last_updated_at: ?i64 = null,

    /// The list of parameters that the `StartCommandExecution` API used when
    /// performing the command on the device.
    parameters: ?[]const aws.map.MapEntry(CommandParameterValue) = null,

    /// The result value for the current state of the command execution. The status
    /// provides
    /// information about the progress of the command execution. The device can use
    /// the result
    /// field to share additional details about the execution such as a return value
    /// of a remote
    /// function call.
    ///
    /// If you use the `AWS-IoT-FleetWise` namespace, then this field is not
    /// applicable in the API response.
    result: ?[]const aws.map.MapEntry(CommandExecutionResult) = null,

    /// The timestamp, when the command execution was started.
    started_at: ?i64 = null,

    /// The status of the command execution. After your devices receive the command
    /// and start
    /// performing the operations specified in the command, it can use the
    /// `UpdateCommandExecution` MQTT API to update the status
    /// information.
    status: ?CommandExecutionStatus = null,

    /// Your devices can use this parameter to provide additional context about the
    /// status of
    /// a command execution using a reason code and description.
    status_reason: ?StatusReason = null,

    /// The Amazon Resource Number (ARN) of the device on which the command
    /// execution is being
    /// performed.
    target_arn: ?[]const u8 = null,

    /// The time to live (TTL) parameter that indicates the duration for which
    /// executions will
    /// be retained in your account. The default value is six months.
    time_to_live: ?i64 = null,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .execution_id = "executionId",
        .execution_timeout_seconds = "executionTimeoutSeconds",
        .last_updated_at = "lastUpdatedAt",
        .parameters = "parameters",
        .result = "result",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .target_arn = "targetArn",
        .time_to_live = "timeToLive",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommandExecutionInput, options: CallOptions) !GetCommandExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommandExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/command-executions/");
    try path_buf.appendSlice(allocator, input.execution_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_result) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeResult=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "targetArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommandExecutionOutput {
    var result: GetCommandExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCommandExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
