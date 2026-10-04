const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFilters = @import("search_filters.zig").SearchFilters;
const SearchType = @import("search_type.zig").SearchType;
const SearchStatus = @import("search_status.zig").SearchStatus;

pub const StartSearchInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure the request is
    /// idempotent. Repeating
    /// a StartSearch call with the same `clientToken` returns the original search
    /// rather than starting
    /// a new one. If omitted, the SDK autogenerates one.
    client_token: ?[]const u8 = null,

    /// An optional caller-supplied identifier used to group related searches
    /// together.
    group_id: ?[]const u8 = null,

    /// The natural-language query describing the data to search for.
    query_statement: []const u8,

    /// Optional filters that restrict the search to a subset of the workspace's
    /// data.
    search_filters: ?SearchFilters = null,

    /// The search strategy to use. Defaults to `QUICK` when omitted.
    search_type: ?SearchType = null,

    /// The name of the workspace whose data is searched.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .group_id = "groupId",
        .query_statement = "queryStatement",
        .search_filters = "searchFilters",
        .search_type = "searchType",
        .workspace_name = "workspaceName",
    };
};

pub const StartSearchOutput = struct {
    /// The group identifier associated with the search, if one was supplied on the
    /// request.
    group_id: ?[]const u8 = null,

    /// The unique identifier assigned to the newly started search.
    search_id: []const u8,

    /// The initial status of the search. A newly started search is `QUEUED`.
    status: SearchStatus,

    /// The name of the workspace the search runs against.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .search_id = "searchId",
        .status = "status",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSearchInput, options: CallOptions) !StartSearchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSearchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/searches");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryStatement\":");
    try aws.json.writeValue(@TypeOf(input.query_statement), input.query_statement, allocator, &body_buf);
    has_prev = true;
    if (input.search_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSearchOutput {
    const result: StartSearchOutput = try aws.json.parseJsonObject(
        StartSearchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
