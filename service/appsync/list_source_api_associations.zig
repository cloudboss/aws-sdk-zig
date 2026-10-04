const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceApiAssociationSummary = @import("source_api_association_summary.zig").SourceApiAssociationSummary;

pub const ListSourceApiAssociationsInput = struct {
    /// The API ID.
    api_id: []const u8,

    /// The maximum number of results that you want the request to return.
    max_results: ?i32 = null,

    /// An identifier that was returned from the previous call to this operation,
    /// which you can
    /// use to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_id = "apiId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSourceApiAssociationsOutput = struct {
    /// An identifier that was returned from the previous call to this operation,
    /// which you can
    /// use to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    /// The `SourceApiAssociationSummary` object data.
    source_api_association_summaries: ?[]const SourceApiAssociationSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .source_api_association_summaries = "sourceApiAssociationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSourceApiAssociationsInput, options: CallOptions) !ListSourceApiAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSourceApiAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/sourceApiAssociations");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSourceApiAssociationsOutput {
    const result: ListSourceApiAssociationsOutput = try aws.json.parseJsonObject(
        ListSourceApiAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
