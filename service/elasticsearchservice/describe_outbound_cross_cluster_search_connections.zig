const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const OutboundCrossClusterSearchConnection = @import("outbound_cross_cluster_search_connection.zig").OutboundCrossClusterSearchConnection;

pub const DescribeOutboundCrossClusterSearchConnectionsInput = struct {
    /// A list of filters used to match properties for outbound cross-cluster search
    /// connection.
    /// Available `Filter` names for this operation are:
    ///
    /// * cross-cluster-search-connection-id
    ///
    /// * destination-domain-info.domain-name
    ///
    /// * destination-domain-info.owner-id
    ///
    /// * destination-domain-info.region
    ///
    /// * source-domain-info.domain-name
    filters: ?[]const Filter = null,

    /// Set this value to limit the number of results returned. If not specified,
    /// defaults to 100.
    max_results: ?i32 = null,

    /// NextToken is sent in case the earlier API call results contain the
    /// NextToken. It is used for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeOutboundCrossClusterSearchConnectionsOutput = struct {
    /// Consists of list of `OutboundCrossClusterSearchConnection` matching the
    /// specified filter criteria.
    cross_cluster_search_connections: ?[]const OutboundCrossClusterSearchConnection = null,

    /// If more results are available and NextToken is present, make the next
    /// request to the same API with the received NextToken to paginate the
    /// remaining results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cross_cluster_search_connections = "CrossClusterSearchConnections",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOutboundCrossClusterSearchConnectionsInput, options: CallOptions) !DescribeOutboundCrossClusterSearchConnectionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOutboundCrossClusterSearchConnectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/ccs/outboundConnection/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOutboundCrossClusterSearchConnectionsOutput {
    var result: DescribeOutboundCrossClusterSearchConnectionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeOutboundCrossClusterSearchConnectionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
