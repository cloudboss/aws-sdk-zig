const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DistributionList = @import("distribution_list.zig").DistributionList;
const serde = @import("serde.zig");

pub const ListDistributionsByWebACLIdInput = struct {
    /// Use `Marker` and `MaxItems` to control pagination of results. If you have
    /// more than `MaxItems` distributions that satisfy the request, the response
    /// includes a `NextMarker` element. To get the next page of results, submit
    /// another request. For the value of `Marker`, specify the value of
    /// `NextMarker` from the last response. (For the first request, omit `Marker`.)
    marker: ?[]const u8 = null,

    /// The maximum number of distributions that you want CloudFront to return in
    /// the response body. The maximum and default values are both 100.
    max_items: ?i32 = null,

    /// The ID of the WAF web ACL that you want to list the associated
    /// distributions. If you specify "null" for the ID, the request returns a list
    /// of the distributions that aren't associated with a web ACL.
    ///
    /// For WAFV2, this is the ARN of the web ACL, such as
    /// `arn:aws:wafv2:us-east-1:123456789012:global/webacl/ExampleWebACL/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    ///
    /// For WAF Classic, this is the ID of the web ACL, such as
    /// `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    web_acl_id: []const u8,
};

pub const ListDistributionsByWebACLIdOutput = struct {
    /// The `DistributionList` type.
    distribution_list: ?DistributionList = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDistributionsByWebACLIdInput, options: CallOptions) !ListDistributionsByWebACLIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDistributionsByWebACLIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distributionsByWebACLId/");
    try path_buf.appendSlice(allocator, input.web_acl_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDistributionsByWebACLIdOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ListDistributionsByWebACLIdOutput = .{};

    return result;
}
