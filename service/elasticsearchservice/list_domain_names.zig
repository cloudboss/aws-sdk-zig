const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngineType = @import("engine_type.zig").EngineType;
const DomainInfo = @import("domain_info.zig").DomainInfo;

pub const ListDomainNamesInput = struct {
    /// Optional parameter to filter the output by domain engine type. Acceptable
    /// values are 'Elasticsearch' and 'OpenSearch'.
    engine_type: ?EngineType = null,

    pub const json_field_names = .{
        .engine_type = "EngineType",
    };
};

pub const ListDomainNamesOutput = struct {
    /// List of domain names and respective engine types.
    domain_names: ?[]const DomainInfo = null,

    pub const json_field_names = .{
        .domain_names = "DomainNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDomainNamesInput, options: CallOptions) !ListDomainNamesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDomainNamesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/domain";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.engine_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "engineType=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDomainNamesOutput {
    var result: ListDomainNamesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDomainNamesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
