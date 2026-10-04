const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorObject = @import("error_object.zig").ErrorObject;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TraceHeader = @import("trace_header.zig").TraceHeader;

pub const GetDurableExecutionInput = struct {
    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
    };
};

pub const GetDurableExecutionOutput = struct {
    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    /// The name of the durable execution. This is either the name you provided when
    /// invoking the function, or a system-generated unique identifier if no name
    /// was provided.
    durable_execution_name: []const u8,

    /// The date and time when the durable execution ended, in Unix timestamp
    /// format. This field is only present if the execution has completed (status is
    /// `SUCCEEDED`, `FAILED`, `TIMED_OUT`, or `STOPPED`).
    end_timestamp: ?i64 = null,

    /// Error information if the durable execution failed. This field is only
    /// present when the execution status is `FAILED`, `TIMED_OUT`, or `STOPPED`.
    /// The combined size of all error fields is limited to 256 KB.
    @"error": ?ErrorObject = null,

    /// The Amazon Resource Name (ARN) of the Lambda function that was invoked to
    /// start this durable execution.
    function_arn: []const u8,

    /// The JSON input payload that was provided when the durable execution was
    /// started. For asynchronous invocations, this is limited to 256 KB. For
    /// synchronous invocations, this can be up to 6 MB.
    input_payload: ?[]const u8 = null,

    /// The JSON result returned by the durable execution if it completed
    /// successfully. This field is only present when the execution status is
    /// `SUCCEEDED`. The result is limited to 256 KB.
    result: ?[]const u8 = null,

    /// The date and time when the durable execution started, in Unix timestamp
    /// format.
    start_timestamp: i64,

    /// The current status of the durable execution. Valid values are `RUNNING`,
    /// `SUCCEEDED`, `FAILED`, `TIMED_OUT`, and `STOPPED`.
    status: ExecutionStatus,

    /// The trace headers associated with the durable execution.
    trace_header: ?TraceHeader = null,

    /// The version of the Lambda function that was invoked for this durable
    /// execution. This ensures that all replays during the execution use the same
    /// function version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
        .durable_execution_name = "DurableExecutionName",
        .end_timestamp = "EndTimestamp",
        .@"error" = "Error",
        .function_arn = "FunctionArn",
        .input_payload = "InputPayload",
        .result = "Result",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
        .trace_header = "TraceHeader",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDurableExecutionInput, options: CallOptions) !GetDurableExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDurableExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-executions/");
    try path_buf.appendSlice(allocator, input.durable_execution_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDurableExecutionOutput {
    var result: GetDurableExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDurableExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
