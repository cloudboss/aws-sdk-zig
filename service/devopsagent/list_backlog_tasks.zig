const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskFilter = @import("task_filter.zig").TaskFilter;
const TaskSortOrder = @import("task_sort_order.zig").TaskSortOrder;
const TaskSortField = @import("task_sort_field.zig").TaskSortField;
const Task = @import("task.zig").Task;

pub const ListBacklogTasksInput = struct {
    /// The unique identifier for the agent space containing the tasks
    agent_space_id: []const u8,

    /// Filter criteria to apply when listing tasks Filtering restrictions: - Each
    /// filter field list is limited to a single value - Filtering by Priority and
    /// Status at the same time when not filtering by Type is not permitted -
    /// Timestamp filters (createdAfter, createdBefore) can be combined with other
    /// filters when not sorting by priority
    filter: ?TaskFilter = null,

    /// Maximum number of tasks to return in a single response (1-1000, default:
    /// 100)
    limit: ?i32 = null,

    /// Token for retrieving the next page of results
    next_token: ?[]const u8 = null,

    /// Sort order for the tasks based on sortField (default: DESC)
    order: ?TaskSortOrder = null,

    /// Field to sort by Sorting restrictions: - Only sorting on createdAt is
    /// supported when using priority or status filters alone. - Sorting by priority
    /// is not supported when using Timestamp filters (createdAfter, createdBefore)
    sort_field: ?TaskSortField = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .filter = "filter",
        .limit = "limit",
        .next_token = "nextToken",
        .order = "order",
        .sort_field = "sortField",
    };
};

pub const ListBacklogTasksOutput = struct {
    /// Token for retrieving the next page of results, if more results are available
    next_token: ?[]const u8 = null,

    /// List of backlog tasks
    tasks: ?[]const Task = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tasks = "tasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBacklogTasksInput, options: CallOptions) !ListBacklogTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBacklogTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backlog/agent-space/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/tasks/list");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.limit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"order\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_field) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortField\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBacklogTasksOutput {
    const result: ListBacklogTasksOutput = try aws.json.parseJsonObject(
        ListBacklogTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
