const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const SetTaskStatusOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetTaskStatusInput, options: Options) !SetTaskStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datapipeline");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetTaskStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineDeletedException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PipelineNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .pipeline_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .task_not_found_exception = .{
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
