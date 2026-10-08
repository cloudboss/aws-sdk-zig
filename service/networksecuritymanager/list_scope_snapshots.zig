const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScopeSummary = @import("scope_summary.zig").ScopeSummary;

pub const ListScopeSnapshotsInput = struct {
    /// The maximum number of results to return in a single call. Valid range:
    /// 1-100. To retrieve the remaining results, use the returned `nextToken` value
    /// in a subsequent call.
    max_results: ?i32 = null,

    /// The token for the next page of results. To retrieve the next page, call the
    /// operation again and provide this value. When there are no more results, this
    /// value is null.
    next_token: ?[]const u8 = null,

    /// The identifier of the scope. This is the scope's Amazon Resource Name (ARN).
    scope_identifier: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .scope_identifier = "scopeIdentifier",
    };
};

pub const ListScopeSnapshotsOutput = struct {
    /// The token for the next page of results. To retrieve the next page, call the
    /// operation again and provide this value. When there are no more results, this
    /// value is null.
    next_token: ?[]const u8 = null,

    /// The snapshots of the scope.
    snapshots: ?[]const ScopeSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .snapshots = "snapshots",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListScopeSnapshotsInput, options: CallOptions) !ListScopeSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListScopeSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scopes/");
    try path_buf.appendSlice(allocator, input.scope_identifier);
    try path_buf.appendSlice(allocator, "/snapshots");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListScopeSnapshotsOutput {
    const result: ListScopeSnapshotsOutput = try aws.json.parseJsonObject(
        ListScopeSnapshotsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
