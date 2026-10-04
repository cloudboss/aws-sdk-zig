const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ElasticsearchDomainStatus = @import("elasticsearch_domain_status.zig").ElasticsearchDomainStatus;

pub const DeleteElasticsearchDomainInput = struct {
    /// The name of the Elasticsearch domain that you want to permanently delete.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const DeleteElasticsearchDomainOutput = struct {
    /// The status of the Elasticsearch domain being deleted.
    domain_status: ?ElasticsearchDomainStatus = null,

    pub const json_field_names = .{
        .domain_status = "DomainStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteElasticsearchDomainInput, options: CallOptions) !DeleteElasticsearchDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteElasticsearchDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteElasticsearchDomainOutput {
    var result: DeleteElasticsearchDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteElasticsearchDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
