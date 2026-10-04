const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GraphQLApiType = @import("graph_ql_api_type.zig").GraphQLApiType;
const Ownership = @import("ownership.zig").Ownership;
const GraphqlApi = @import("graphql_api.zig").GraphqlApi;

pub const ListGraphqlApisInput = struct {
    /// The value that indicates whether the GraphQL API is a standard API
    /// (`GRAPHQL`) or merged API (`MERGED`).
    api_type: ?GraphQLApiType = null,

    /// The maximum number of results that you want the request to return.
    max_results: ?i32 = null,

    /// An identifier that was returned from the previous call to this operation,
    /// which you can
    /// use to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    /// The account owner of the GraphQL API.
    owner: ?Ownership = null,

    pub const json_field_names = .{
        .api_type = "apiType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .owner = "owner",
    };
};

pub const ListGraphqlApisOutput = struct {
    /// The `GraphqlApi` objects.
    graphql_apis: ?[]const GraphqlApi = null,

    /// An identifier to pass in the next request to this operation to return the
    /// next set of
    /// items in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .graphql_apis = "graphqlApis",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGraphqlApisInput, options: CallOptions) !ListGraphqlApisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGraphqlApisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/apis";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.api_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "apiType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "owner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGraphqlApisOutput {
    var result: ListGraphqlApisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListGraphqlApisOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
