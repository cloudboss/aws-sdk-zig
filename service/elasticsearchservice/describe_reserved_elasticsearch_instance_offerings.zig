const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedElasticsearchInstanceOffering = @import("reserved_elasticsearch_instance_offering.zig").ReservedElasticsearchInstanceOffering;

pub const DescribeReservedElasticsearchInstanceOfferingsInput = struct {
    /// Set this value to limit the number of results returned. If not specified,
    /// defaults to 100.
    max_results: ?i32 = null,

    /// NextToken should be sent in case if earlier API call produced result
    /// containing NextToken. It is used for pagination.
    next_token: ?[]const u8 = null,

    /// The offering identifier filter value. Use this parameter to show only the
    /// available offering that matches the specified reservation identifier.
    reserved_elasticsearch_instance_offering_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .reserved_elasticsearch_instance_offering_id = "ReservedElasticsearchInstanceOfferingId",
    };
};

pub const DescribeReservedElasticsearchInstanceOfferingsOutput = struct {
    /// Provides an identifier to allow retrieval of paginated results.
    next_token: ?[]const u8 = null,

    /// List of reserved Elasticsearch instance offerings
    reserved_elasticsearch_instance_offerings: ?[]const ReservedElasticsearchInstanceOffering = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reserved_elasticsearch_instance_offerings = "ReservedElasticsearchInstanceOfferings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedElasticsearchInstanceOfferingsInput, options: CallOptions) !DescribeReservedElasticsearchInstanceOfferingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedElasticsearchInstanceOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/reservedInstanceOfferings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.reserved_elasticsearch_instance_offering_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "offeringId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedElasticsearchInstanceOfferingsOutput {
    const result: DescribeReservedElasticsearchInstanceOfferingsOutput = try aws.json.parseJsonObject(
        DescribeReservedElasticsearchInstanceOfferingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
