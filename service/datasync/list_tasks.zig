const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskFilter = @import("task_filter.zig").TaskFilter;
const TaskListEntry = @import("task_list_entry.zig").TaskListEntry;

pub const ListTasksInput = struct {
    /// You can use API filters to narrow down the list of resources returned by
    /// `ListTasks`. For example, to retrieve all tasks on a specific source
    /// location,
    /// you can use `ListTasks` with filter name `LocationId` and `Operator
    /// Equals` with the ARN for the location.
    filters: ?[]const TaskFilter = null,

    /// The maximum number of tasks to return.
    max_results: ?i32 = null,

    /// An opaque string that indicates the position at which to begin the next list
    /// of
    /// tasks.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTasksOutput = struct {
    /// An opaque string that indicates the position at which to begin returning the
    /// next list
    /// of tasks.
    next_token: ?[]const u8 = null,

    /// A list of all the tasks that are returned.
    tasks: ?[]const TaskListEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tasks = "Tasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTasksInput, options: CallOptions) !ListTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.ListTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTasksOutput, body, allocator);
}
