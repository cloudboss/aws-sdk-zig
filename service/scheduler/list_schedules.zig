const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleState = @import("schedule_state.zig").ScheduleState;
const ScheduleSummary = @import("schedule_summary.zig").ScheduleSummary;

pub const ListSchedulesInput = struct {
    /// If specified, only lists the schedules whose associated schedule group
    /// matches the given filter.
    group_name: ?[]const u8 = null,

    /// If specified, limits the number of results returned by this operation. The
    /// operation also returns a `NextToken` which you can use in a subsequent
    /// operation to retrieve the next set of results.
    max_results: ?i32 = null,

    /// Schedule name prefix to return the filtered list of resources.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// If specified, only lists the schedules whose current state matches the given
    /// filter.
    state: ?ScheduleState = null,

    pub const json_field_names = .{
        .group_name = "GroupName",
        .max_results = "MaxResults",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
        .state = "State",
    };
};

pub const ListSchedulesOutput = struct {
    /// Indicates whether there are additional results to retrieve. If the value is
    /// null, there are no more results.
    next_token: ?[]const u8 = null,

    /// The schedules that match the specified criteria.
    schedules: ?[]const ScheduleSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .schedules = "Schedules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSchedulesInput, options: CallOptions) !ListSchedulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scheduler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSchedulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scheduler", "Scheduler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/schedules";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.group_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ScheduleGroup=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
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
    if (input.name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "State=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSchedulesOutput {
    const result: ListSchedulesOutput = try aws.json.parseJsonObject(
        ListSchedulesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
