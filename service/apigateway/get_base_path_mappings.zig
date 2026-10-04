const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BasePathMapping = @import("base_path_mapping.zig").BasePathMapping;

pub const GetBasePathMappingsInput = struct {
    /// The domain name of a BasePathMapping resource.
    domain_name: []const u8,

    /// The identifier for the domain name resource. Supported only for private
    /// custom domain names.
    domain_name_id: ?[]const u8 = null,

    /// The maximum number of returned results per page. The default value is 25 and
    /// the maximum value is 500.
    limit: ?i32 = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .domain_name_id = "domainNameId",
        .limit = "limit",
        .position = "position",
    };
};

pub const GetBasePathMappingsOutput = struct {
    /// The current page of elements from this collection.
    items: ?[]const BasePathMapping = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .position = "position",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBasePathMappingsInput, options: CallOptions) !GetBasePathMappingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBasePathMappingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/basepathmappings");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainNameId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBasePathMappingsOutput {
    var result: GetBasePathMappingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBasePathMappingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
