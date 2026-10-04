const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ESPartitionInstanceType = @import("es_partition_instance_type.zig").ESPartitionInstanceType;

pub const ListElasticsearchInstanceTypesInput = struct {
    /// DomainName represents the name of the Domain that we are trying to modify.
    /// This should be present only if we are
    /// querying for list of available Elasticsearch instance types when modifying
    /// existing domain.
    domain_name: ?[]const u8 = null,

    /// Version of Elasticsearch for which list of supported elasticsearch
    /// instance types are needed.
    elasticsearch_version: []const u8,

    /// Set this value to limit the number of results returned.
    /// Value provided must be greater than 30 else it wont be honored.
    max_results: ?i32 = null,

    /// NextToken should be sent in case if earlier API call produced result
    /// containing NextToken. It is used for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .elasticsearch_version = "ElasticsearchVersion",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListElasticsearchInstanceTypesOutput = struct {
    /// List of instance types supported by Amazon Elasticsearch service for
    /// given
    /// `
    /// ElasticsearchVersion
    /// `
    elasticsearch_instance_types: ?[]const ESPartitionInstanceType = null,

    /// In case if there are more results available NextToken would be
    /// present, make further request to the same API with
    /// received NextToken to paginate remaining results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .elasticsearch_instance_types = "ElasticsearchInstanceTypes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListElasticsearchInstanceTypesInput, options: CallOptions) !ListElasticsearchInstanceTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListElasticsearchInstanceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/instanceTypes/");
    try path_buf.appendSlice(allocator, input.elasticsearch_version);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListElasticsearchInstanceTypesOutput {
    var result: ListElasticsearchInstanceTypesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListElasticsearchInstanceTypesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
