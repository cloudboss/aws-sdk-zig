const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskStatus = @import("task_status.zig").TaskStatus;

pub const SetTaskStatusInput = struct {
    /// If an error occurred during the task, this value specifies the error code.
    /// This value is set on the physical attempt object.
    /// It is used to display error information to the user. It should not start
    /// with string "Service_" which is reserved by the system.
    error_id: ?[]const u8 = null,

    /// If an error occurred during the task, this value specifies a text
    /// description of the error. This value is set on the physical attempt object.
    /// It is used to display error information to the user. The web service does
    /// not parse this value.
    error_message: ?[]const u8 = null,

    /// If an error occurred during the task, this value specifies the stack trace
    /// associated with the error. This value is set on the physical attempt object.
    /// It is used to display error information to the user. The web service does
    /// not parse this value.
    error_stack_trace: ?[]const u8 = null,

    /// The ID of the task assigned to the task runner. This value is provided in
    /// the response for PollForTask.
    task_id: []const u8,

    /// If `FINISHED`, the task successfully completed. If `FAILED`, the task ended
    /// unsuccessfully. Preconditions use false.
    task_status: TaskStatus,

    pub const json_field_names = .{
        .error_id = "errorId",
        .error_message = "errorMessage",
        .error_stack_trace = "errorStackTrace",
        .task_id = "taskId",
        .task_status = "taskStatus",
    };
};

pub const SetTaskStatusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetTaskStatusInput, options: CallOptions) !SetTaskStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetTaskStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.SetTaskStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetTaskStatusOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
