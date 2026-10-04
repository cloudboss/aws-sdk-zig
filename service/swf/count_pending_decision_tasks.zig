const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskList = @import("task_list.zig").TaskList;

pub const CountPendingDecisionTasksInput = struct {
    /// The name of the domain that contains the task list.
    domain: []const u8,

    /// The name of the task list.
    task_list: TaskList,

    pub const json_field_names = .{
        .domain = "domain",
        .task_list = "taskList",
    };
};

pub const CountPendingDecisionTasksOutput = struct {
    /// The number of tasks in the task list.
    count: ?i32 = null,

    /// If set to true, indicates that the actual count was more than the maximum
    /// supported by this API and the count returned is the truncated value.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .count = "count",
        .truncated = "truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CountPendingDecisionTasksInput, options: CallOptions) !CountPendingDecisionTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CountPendingDecisionTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.CountPendingDecisionTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CountPendingDecisionTasksOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CountPendingDecisionTasksOutput, body, allocator);
}
