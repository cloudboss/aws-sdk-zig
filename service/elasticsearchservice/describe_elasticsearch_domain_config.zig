const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ElasticsearchDomainConfig = @import("elasticsearch_domain_config.zig").ElasticsearchDomainConfig;

pub const DescribeElasticsearchDomainConfigInput = struct {
    /// The Elasticsearch domain that you want to get information about.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const DescribeElasticsearchDomainConfigOutput = struct {
    /// The configuration information of the domain requested in the
    /// `DescribeElasticsearchDomainConfig` request.
    domain_config: ?ElasticsearchDomainConfig = null,

    pub const json_field_names = .{
        .domain_config = "DomainConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeElasticsearchDomainConfigInput, options: CallOptions) !DescribeElasticsearchDomainConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeElasticsearchDomainConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeElasticsearchDomainConfigOutput {
    const result: DescribeElasticsearchDomainConfigOutput = try aws.json.parseJsonObject(
        DescribeElasticsearchDomainConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
