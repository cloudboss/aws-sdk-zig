const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompatibleVersionsMap = @import("compatible_versions_map.zig").CompatibleVersionsMap;

pub const GetCompatibleElasticsearchVersionsInput = struct {
    domain_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetCompatibleElasticsearchVersionsOutput = struct {
    /// A map of compatible Elasticsearch versions returned as part of the
    /// `
    /// GetCompatibleElasticsearchVersions
    /// `
    /// operation.
    compatible_elasticsearch_versions: ?[]const CompatibleVersionsMap = null,

    pub const json_field_names = .{
        .compatible_elasticsearch_versions = "CompatibleElasticsearchVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCompatibleElasticsearchVersionsInput, options: CallOptions) !GetCompatibleElasticsearchVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCompatibleElasticsearchVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/compatibleVersions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCompatibleElasticsearchVersionsOutput {
    const result: GetCompatibleElasticsearchVersionsOutput = try aws.json.parseJsonObject(
        GetCompatibleElasticsearchVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
