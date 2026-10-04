const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceTypeDetails = @import("instance_type_details.zig").InstanceTypeDetails;

pub const ListInstanceTypeDetailsInput = struct {
    /// The name of the domain.
    domain_name: ?[]const u8 = null,

    /// The version of OpenSearch or Elasticsearch, in the format Elasticsearch_X.Y
    /// or
    /// OpenSearch_X.Y. Defaults to the latest version of OpenSearch.
    engine_version: []const u8,

    /// An optional parameter that lists information for a given instance type.
    instance_type: ?[]const u8 = null,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can
    /// use `nextToken` to get the next page of results.
    max_results: ?i32 = null,

    /// If your initial `ListInstanceTypeDetails` operation returns a
    /// `nextToken`, you can include the returned `nextToken` in
    /// subsequent `ListInstanceTypeDetails` operations, which returns results in
    /// the
    /// next page.
    next_token: ?[]const u8 = null,

    /// An optional parameter that specifies the Availability Zones for the domain.
    retrieve_a_zs: ?bool = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .engine_version = "EngineVersion",
        .instance_type = "InstanceType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .retrieve_a_zs = "RetrieveAZs",
    };
};

pub const ListInstanceTypeDetailsOutput = struct {
    /// Lists all supported instance types and features for the given OpenSearch or
    /// Elasticsearch version.
    instance_type_details: ?[]const InstanceTypeDetails = null,

    /// When `nextToken` is returned, there are more results available. The value
    /// of `nextToken` is a unique pagination token for each page. Send the request
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_type_details = "InstanceTypeDetails",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstanceTypeDetailsInput, options: CallOptions) !ListInstanceTypeDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstanceTypeDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/instanceTypeDetails/");
    try path_buf.appendSlice(allocator, input.engine_version);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.instance_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "instanceType=");
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
    if (input.retrieve_a_zs) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "retrieveAZs=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstanceTypeDetailsOutput {
    var result: ListInstanceTypeDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListInstanceTypeDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
