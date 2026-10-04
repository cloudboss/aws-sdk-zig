const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityTaskStatus = @import("capacity_task_status.zig").CapacityTaskStatus;
const CapacityTaskSummary = @import("capacity_task_summary.zig").CapacityTaskSummary;

pub const ListCapacityTasksInput = struct {
    /// A list of statuses. For example, `REQUESTED` or
    /// `WAITING_FOR_EVACUATION`.
    capacity_task_status_filter: ?[]const CapacityTaskStatus = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Filters the results by an Outpost ID or an Outpost ARN.
    outpost_identifier_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_task_status_filter = "CapacityTaskStatusFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .outpost_identifier_filter = "OutpostIdentifierFilter",
    };
};

pub const ListCapacityTasksOutput = struct {
    /// Lists all the capacity tasks.
    capacity_tasks: ?[]const CapacityTaskSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_tasks = "CapacityTasks",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCapacityTasksInput, options: CallOptions) !ListCapacityTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCapacityTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/capacity/tasks";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.capacity_task_status_filter) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "CapacityTaskStatusFilter=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.outpost_identifier_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OutpostIdentifierFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCapacityTasksOutput {
    var result: ListCapacityTasksOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCapacityTasksOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
