const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceSummary = @import("workspace_summary.zig").WorkspaceSummary;

pub const ListWorkspacesInput = struct {
    /// If this is included, it filters the results to only the workspaces with
    /// names that start with the value that you specify here.
    ///
    /// Amazon Managed Service for Prometheus will automatically strip any blank
    /// spaces from the beginning and end of the alias that you specify.
    alias: ?[]const u8 = null,

    /// The maximum number of workspaces to return per request. The default is 100.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. You receive this token from a
    /// previous call, and use it to get the next page of results. The other
    /// parameters must be the same as the initial call.
    ///
    /// For example, if your initial request has `maxResults` of 10, and there are
    /// 12 workspaces to return, then your initial request will return 10 and a
    /// `nextToken`. Using the next token in a subsequent call will return the
    /// remaining 2 workspaces.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListWorkspacesOutput = struct {
    /// A token indicating that there are more results to retrieve. You can use this
    /// token as part of your next `ListWorkspaces` request to retrieve those
    /// results.
    next_token: ?[]const u8 = null,

    /// An array of `WorkspaceSummary` structures containing information about the
    /// workspaces requested.
    workspaces: ?[]const WorkspaceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .workspaces = "workspaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkspacesInput, options: CallOptions) !ListWorkspacesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkspacesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workspaces";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "alias=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkspacesOutput {
    var result: ListWorkspacesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkspacesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
