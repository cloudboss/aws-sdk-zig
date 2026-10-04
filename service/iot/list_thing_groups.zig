const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupNameAndArn = @import("group_name_and_arn.zig").GroupNameAndArn;

pub const ListThingGroupsInput = struct {
    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// A filter that limits the results to those with the specified name prefix.
    name_prefix_filter: ?[]const u8 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// A filter that limits the results to those with the specified parent group.
    parent_group: ?[]const u8 = null,

    /// If true, return child groups as well.
    recursive: ?bool = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name_prefix_filter = "namePrefixFilter",
        .next_token = "nextToken",
        .parent_group = "parentGroup",
        .recursive = "recursive",
    };
};

pub const ListThingGroupsOutput = struct {
    /// The token to use to get the next set of results. Will not be returned if
    /// operation has returned all results.
    next_token: ?[]const u8 = null,

    /// The thing groups.
    thing_groups: ?[]const GroupNameAndArn = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .thing_groups = "thingGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListThingGroupsInput, options: CallOptions) !ListThingGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListThingGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/thing-groups";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name_prefix_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namePrefixFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.parent_group) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "parentGroup=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.recursive) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recursive=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListThingGroupsOutput {
    const result: ListThingGroupsOutput = try aws.json.parseJsonObject(
        ListThingGroupsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
