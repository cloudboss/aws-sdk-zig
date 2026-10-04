const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchType = @import("search_type.zig").SearchType;
const SearchStatus = @import("search_status.zig").SearchStatus;

pub const DescribeSearchInput = struct {
    /// The identifier of the search to describe.
    search_id: []const u8,

    /// The name of the workspace the search belongs to.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .search_id = "searchId",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeSearchOutput = struct {
    /// The group identifier associated with the search, if one was supplied on the
    /// request.
    group_id: ?[]const u8 = null,

    /// The natural-language query that was submitted for the search.
    query_statement: []const u8,

    /// The unique identifier of the search.
    search_id: []const u8,

    /// The search strategy used for the search.
    search_type: SearchType,

    /// The time at which the search was started.
    started_at: ?i64 = null,

    /// The current status of the search.
    status: SearchStatus,

    /// A human-readable explanation of the current status. Populated when the
    /// search has `FAILED`.
    status_reason: ?[]const u8 = null,

    /// The name of the workspace the search runs against.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .query_statement = "queryStatement",
        .search_id = "searchId",
        .search_type = "searchType",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSearchInput, options: CallOptions) !DescribeSearchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSearchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/searches/");
    try path_buf.appendSlice(allocator, input.search_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSearchOutput {
    const result: DescribeSearchOutput = try aws.json.parseJsonObject(
        DescribeSearchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
