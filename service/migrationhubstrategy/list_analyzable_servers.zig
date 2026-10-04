const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const AnalyzableServerSummary = @import("analyzable_server_summary.zig").AnalyzableServerSummary;

pub const ListAnalyzableServersInput = struct {
    /// The maximum number of items to include in the response. The maximum value is
    /// 100.
    max_results: ?i32 = null,

    /// The token from a previous call that you use to retrieve the next set of
    /// results. For example, if a previous call to this action returned 100 items,
    /// but you set maxResults to 10. You'll receive a set of 10 results along with
    /// a token. You then use the returned token to retrieve the next set of 10.
    next_token: ?[]const u8 = null,

    /// Specifies whether to sort by ascending (ASC) or descending (DESC) order.
    sort: ?SortOrder = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort = "sort",
    };
};

pub const ListAnalyzableServersOutput = struct {
    /// The list of analyzable servers with summary information about each server.
    analyzable_servers: ?[]const AnalyzableServerSummary = null,

    /// The token you use to retrieve the next set of results, or null if there are
    /// no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzable_servers = "analyzableServers",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAnalyzableServersInput, options: CallOptions) !ListAnalyzableServersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAnalyzableServersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-analyzable-servers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sort\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAnalyzableServersOutput {
    var result: ListAnalyzableServersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAnalyzableServersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
