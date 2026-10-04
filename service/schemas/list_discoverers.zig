const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscovererSummary = @import("discoverer_summary.zig").DiscovererSummary;

pub const ListDiscoverersInput = struct {
    /// Specifying this limits the results to only those discoverer IDs that start
    /// with the specified prefix.
    discoverer_id_prefix: ?[]const u8 = null,

    limit: ?i32 = null,

    /// The token that specifies the next page of results to return. To request the
    /// first page, leave NextToken empty. The token will expire in 24 hours, and
    /// cannot be shared with other accounts.
    next_token: ?[]const u8 = null,

    /// Specifying this limits the results to only those ARNs that start with the
    /// specified prefix.
    source_arn_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .discoverer_id_prefix = "DiscovererIdPrefix",
        .limit = "Limit",
        .next_token = "NextToken",
        .source_arn_prefix = "SourceArnPrefix",
    };
};

pub const ListDiscoverersOutput = struct {
    /// An array of DiscovererSummary information.
    discoverers: ?[]const DiscovererSummary = null,

    /// The token that specifies the next page of results to return. To request the
    /// first page, leave NextToken empty. The token will expire in 24 hours, and
    /// cannot be shared with other accounts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .discoverers = "Discoverers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDiscoverersInput, options: CallOptions) !ListDiscoverersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "schemas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDiscoverersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("schemas", "schemas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/discoverers";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.discoverer_id_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "discovererIdPrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
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
    if (input.source_arn_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sourceArnPrefix=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDiscoverersOutput {
    const result: ListDiscoverersOutput = try aws.json.parseJsonObject(
        ListDiscoverersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
