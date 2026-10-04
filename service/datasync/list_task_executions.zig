const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskExecutionListEntry = @import("task_execution_list_entry.zig").TaskExecutionListEntry;

pub const ListTaskExecutionsInput = struct {
    /// Specifies how many results you want in the response.
    max_results: ?i32 = null,

    /// Specifies an opaque string that indicates the position at which to begin the
    /// next list
    /// of results in the response.
    next_token: ?[]const u8 = null,

    /// Specifies the Amazon Resource Name (ARN) of the task that you want execution
    /// information about.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .task_arn = "TaskArn",
    };
};

pub const ListTaskExecutionsOutput = struct {
    /// The opaque string that indicates the position to begin the next list of
    /// results in the
    /// response.
    next_token: ?[]const u8 = null,

    /// A list of the task's executions.
    task_executions: ?[]const TaskExecutionListEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_executions = "TaskExecutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTaskExecutionsInput, options: CallOptions) !ListTaskExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datasync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTaskExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.ListTaskExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTaskExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTaskExecutionsOutput, body, allocator);
}
