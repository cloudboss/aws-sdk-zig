const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const DistributionList = @import("distribution_list.zig").DistributionList;
const serde = @import("serde.zig");

pub const ListDistributionsByConnectionModeInput = struct {
    /// This field specifies whether the connection mode is through a standard
    /// distribution (direct) or a multi-tenant distribution with distribution
    /// tenants (tenant-only).
    connection_mode: ConnectionMode,

    /// The marker for the next set of distributions to retrieve.
    marker: ?[]const u8 = null,

    /// The maximum number of distributions to return.
    max_items: ?i32 = null,
};

pub const ListDistributionsByConnectionModeOutput = struct {
    distribution_list: ?DistributionList = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDistributionsByConnectionModeInput, options: CallOptions) !ListDistributionsByConnectionModeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDistributionsByConnectionModeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distributionsByConnectionMode/");
    try path_buf.appendSlice(allocator, input.connection_mode.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDistributionsByConnectionModeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ListDistributionsByConnectionModeOutput = .{};

    return result;
}
