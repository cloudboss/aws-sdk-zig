const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ESPartitionInstanceType = @import("es_partition_instance_type.zig").ESPartitionInstanceType;
const Limits = @import("limits.zig").Limits;

pub const DescribeElasticsearchInstanceTypeLimitsInput = struct {
    /// DomainName represents the name of the Domain that we are trying to
    /// modify. This should be present only if we are
    /// querying for Elasticsearch
    /// `
    /// Limits
    /// `
    /// for existing domain.
    domain_name: ?[]const u8 = null,

    /// Version of Elasticsearch for which
    /// `
    /// Limits
    /// `
    /// are needed.
    elasticsearch_version: []const u8,

    /// The instance type for an Elasticsearch cluster for which Elasticsearch
    /// `
    /// Limits
    /// `
    /// are needed.
    instance_type: ESPartitionInstanceType,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .elasticsearch_version = "ElasticsearchVersion",
        .instance_type = "InstanceType",
    };
};

pub const DescribeElasticsearchInstanceTypeLimitsOutput = struct {
    limits_by_role: ?[]const aws.map.MapEntry(Limits) = null,

    pub const json_field_names = .{
        .limits_by_role = "LimitsByRole",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeElasticsearchInstanceTypeLimitsInput, options: CallOptions) !DescribeElasticsearchInstanceTypeLimitsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeElasticsearchInstanceTypeLimitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/instanceTypeLimits/");
    try path_buf.appendSlice(allocator, input.elasticsearch_version);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.instance_type);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeElasticsearchInstanceTypeLimitsOutput {
    const result: DescribeElasticsearchInstanceTypeLimitsOutput = try aws.json.parseJsonObject(
        DescribeElasticsearchInstanceTypeLimitsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
