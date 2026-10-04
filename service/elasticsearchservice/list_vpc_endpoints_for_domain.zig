const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcEndpointSummary = @import("vpc_endpoint_summary.zig").VpcEndpointSummary;

pub const ListVpcEndpointsForDomainInput = struct {
    /// Name of the ElasticSearch domain whose VPC endpoints are to be listed.
    domain_name: []const u8,

    /// Provides an identifier to allow retrieval of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .next_token = "NextToken",
    };
};

pub const ListVpcEndpointsForDomainOutput = struct {
    /// Information about each endpoint associated with the domain.
    next_token: []const u8,

    /// Provides list of `VpcEndpointSummary` summarizing details of the VPC
    /// endpoints.
    vpc_endpoint_summary_list: ?[]const VpcEndpointSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .vpc_endpoint_summary_list = "VpcEndpointSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVpcEndpointsForDomainInput, options: CallOptions) !ListVpcEndpointsForDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVpcEndpointsForDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/vpcEndpoints");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVpcEndpointsForDomainOutput {
    var result: ListVpcEndpointsForDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListVpcEndpointsForDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
