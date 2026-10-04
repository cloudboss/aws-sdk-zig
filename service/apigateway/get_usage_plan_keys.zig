const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsagePlanKey = @import("usage_plan_key.zig").UsagePlanKey;

pub const GetUsagePlanKeysInput = struct {
    /// The maximum number of returned results per page. The default value is 25 and
    /// the maximum value is 500.
    limit: ?i32 = null,

    /// A query parameter specifying the name of the to-be-returned usage plan keys.
    name_query: ?[]const u8 = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    /// The Id of the UsagePlan resource representing the usage plan containing the
    /// to-be-retrieved UsagePlanKey resource representing a plan customer.
    usage_plan_id: []const u8,

    pub const json_field_names = .{
        .limit = "limit",
        .name_query = "nameQuery",
        .position = "position",
        .usage_plan_id = "usagePlanId",
    };
};

pub const GetUsagePlanKeysOutput = struct {
    /// The current page of elements from this collection.
    items: ?[]const UsagePlanKey = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .position = "position",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUsagePlanKeysInput, options: CallOptions) !GetUsagePlanKeysOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUsagePlanKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/usageplans/");
    try path_buf.appendSlice(allocator, input.usage_plan_id);
    try path_buf.appendSlice(allocator, "/keys");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUsagePlanKeysOutput {
    var result: GetUsagePlanKeysOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUsagePlanKeysOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
