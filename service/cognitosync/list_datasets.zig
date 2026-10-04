const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Dataset = @import("dataset.zig").Dataset;

pub const ListDatasetsInput = struct {
    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_id: []const u8,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_pool_id: []const u8,

    /// The maximum number of results to be
    /// returned.
    max_results: ?i32 = null,

    /// A pagination token for obtaining the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDatasetsOutput = struct {
    /// Number of datasets returned.
    count: ?i32 = null,

    /// A set of datasets.
    datasets: ?[]const Dataset = null,

    /// A pagination token for obtaining the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .datasets = "Datasets",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetsInput, options: CallOptions) !ListDatasetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-sync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-sync", "Cognito Sync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/identitypools/");
    try path_buf.appendSlice(allocator, input.identity_pool_id);
    try path_buf.appendSlice(allocator, "/identities/");
    try path_buf.appendSlice(allocator, input.identity_id);
    try path_buf.appendSlice(allocator, "/datasets");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetsOutput {
    const result: ListDatasetsOutput = try aws.json.parseJsonObject(
        ListDatasetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
