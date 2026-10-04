const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiRegionEndpoint = @import("multi_region_endpoint.zig").MultiRegionEndpoint;

pub const ListMultiRegionEndpointsInput = struct {
    /// A token returned from a previous call to `ListMultiRegionEndpoints` to
    /// indicate
    /// the position in the list of multi-region endpoints (global-endpoints).
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to
    /// `ListMultiRegionEndpoints`.
    /// If the number of results is larger than the number you specified in this
    /// parameter,
    /// the response includes a `NextToken` element
    /// that you can use to retrieve the next page of results.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListMultiRegionEndpointsOutput = struct {
    /// An array that contains key multi-region endpoint (global-endpoint)
    /// properties.
    multi_region_endpoints: ?[]const MultiRegionEndpoint = null,

    /// A token indicating that there are additional multi-region endpoints
    /// (global-endpoints) available to be listed.
    /// Pass this token to a subsequent `ListMultiRegionEndpoints` call to retrieve
    /// the
    /// next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .multi_region_endpoints = "MultiRegionEndpoints",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMultiRegionEndpointsInput, options: CallOptions) !ListMultiRegionEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMultiRegionEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/multi-region-endpoints";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PageSize=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMultiRegionEndpointsOutput {
    const result: ListMultiRegionEndpointsOutput = try aws.json.parseJsonObject(
        ListMultiRegionEndpointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
