const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportTaskStatusCode = @import("export_task_status_code.zig").ExportTaskStatusCode;
const ExportTask = @import("export_task.zig").ExportTask;

pub const DescribeExportTasksInput = struct {
    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The status code of the export task. Specifying a status code filters the
    /// results to
    /// zero or more export tasks.
    status_code: ?ExportTaskStatusCode = null,

    /// The ID of the export task. Specifying a task ID filters the results to one
    /// or zero
    /// export tasks.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "limit",
        .next_token = "nextToken",
        .status_code = "statusCode",
        .task_id = "taskId",
    };
};

pub const DescribeExportTasksOutput = struct {
    /// The export tasks.
    export_tasks: ?[]const ExportTask = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_tasks = "exportTasks",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExportTasksInput, options: CallOptions) !DescribeExportTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExportTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeExportTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExportTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeExportTasksOutput, body, allocator);
}
