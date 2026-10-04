const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleGroupSummary = @import("schedule_group_summary.zig").ScheduleGroupSummary;

pub const ListScheduleGroupsInput = struct {
    /// If specified, limits the number of results returned by this operation. The
    /// operation also returns a `NextToken` which you can use in a subsequent
    /// operation to retrieve the next set of results.
    max_results: ?i32 = null,

    /// The name prefix that you can use to return a filtered list of your schedule
    /// groups.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};

pub const ListScheduleGroupsOutput = struct {
    /// Indicates whether there are additional results to retrieve. If the value is
    /// null, there are no more results.
    next_token: ?[]const u8 = null,

    /// The schedule groups that match the specified criteria.
    schedule_groups: ?[]const ScheduleGroupSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .schedule_groups = "ScheduleGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScheduleGroupsInput, options: CallOptions) !ListScheduleGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListScheduleGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scheduler", "Scheduler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/schedule-groups";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScheduleGroupsOutput {
    const result: ListScheduleGroupsOutput = try aws.json.parseJsonObject(
        ListScheduleGroupsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
