const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiKey = @import("api_key.zig").ApiKey;

pub const GetApiKeysInput = struct {
    /// The identifier of a customer in Amazon Web Services Marketplace or an
    /// external system, such as a developer portal.
    customer_id: ?[]const u8 = null,

    /// A boolean flag to specify whether (`true`) or not (`false`) the result
    /// contains key values.
    include_values: ?bool = null,

    /// The maximum number of returned results per page. The default value is 25 and
    /// the maximum value is 500.
    limit: ?i32 = null,

    /// The name of queried API keys.
    name_query: ?[]const u8 = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_id = "customerId",
        .include_values = "includeValues",
        .limit = "limit",
        .name_query = "nameQuery",
        .position = "position",
    };
};

pub const GetApiKeysOutput = struct {
    /// The current page of elements from this collection.
    items: ?[]const ApiKey = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    /// A list of warning messages logged during the import of API keys when the
    /// `failOnWarnings` option is set to true.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .position = "position",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApiKeysInput, options: CallOptions) !GetApiKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApiKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apikeys";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.customer_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "customerId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.include_values) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeValues=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.name_query) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.position) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "position=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApiKeysOutput {
    var result: GetApiKeysOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetApiKeysOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
