const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Endpoint = @import("endpoint.zig").Endpoint;

pub const ListSharedEndpointsInput = struct {
    /// The maximum number of endpoints that will be returned in the response.
    max_results: ?i32 = null,

    /// If a previous response from this operation included a `NextToken` value, you
    /// can provide that value here to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The ID of the Amazon Web Services Outpost.
    outpost_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .outpost_id = "OutpostId",
    };
};

pub const ListSharedEndpointsOutput = struct {
    /// The list of endpoints associated with the specified Outpost that have been
    /// shared by Amazon Web Services Resource Access Manager (RAM).
    endpoints: ?[]const Endpoint = null,

    /// If the number of endpoints associated with the specified Outpost exceeds
    /// `MaxResults`,
    /// you can include this value in subsequent calls to this operation to retrieve
    /// more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSharedEndpointsInput, options: CallOptions) !ListSharedEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3-outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSharedEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-outposts", "S3Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/S3Outposts/ListSharedEndpoints";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "outpostId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.outpost_id);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSharedEndpointsOutput {
    const result: ListSharedEndpointsOutput = try aws.json.parseJsonObject(
        ListSharedEndpointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
