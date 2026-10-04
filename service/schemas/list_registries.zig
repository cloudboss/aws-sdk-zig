const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrySummary = @import("registry_summary.zig").RegistrySummary;

pub const ListRegistriesInput = struct {
    limit: ?i32 = null,

    /// The token that specifies the next page of results to return. To request the
    /// first page, leave NextToken empty. The token will expire in 24 hours, and
    /// cannot be shared with other accounts.
    next_token: ?[]const u8 = null,

    /// Specifying this limits the results to only those registry names that start
    /// with the specified prefix.
    registry_name_prefix: ?[]const u8 = null,

    /// Can be set to Local or AWS to limit responses to your custom registries, or
    /// the ones provided by AWS.
    scope: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_token = "NextToken",
        .registry_name_prefix = "RegistryNamePrefix",
        .scope = "Scope",
    };
};

pub const ListRegistriesOutput = struct {
    /// The token that specifies the next page of results to return. To request the
    /// first page, leave NextToken empty. The token will expire in 24 hours, and
    /// cannot be shared with other accounts.
    next_token: ?[]const u8 = null,

    /// An array of registry summaries.
    registries: ?[]const RegistrySummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .registries = "Registries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRegistriesInput, options: CallOptions) !ListRegistriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRegistriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("schemas", "schemas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/registries";

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
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.registry_name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "registryNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.scope) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "scope=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRegistriesOutput {
    var result: ListRegistriesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRegistriesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
