const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteRouteInput = struct {
    /// The IPv4 CIDR range for the route. The value you specify must match the CIDR
    /// for the route exactly.
    destination_cidr_block: ?[]const u8 = null,

    /// The IPv6 CIDR range for the route. The value you specify must match the CIDR
    /// for the route exactly.
    destination_ipv_6_cidr_block: ?[]const u8 = null,

    /// The ID of the prefix list for the route.
    destination_prefix_list_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the route table.
    route_table_id: []const u8,
};

pub const DeleteRouteOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRouteInput, options: CallOptions) !DeleteRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteRoute&Version=2016-11-15");
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&DestinationCidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&DestinationIpv6CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_prefix_list_id) |v| {
        try body_buf.appendSlice(allocator, "&DestinationPrefixListId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&RouteTableId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.route_table_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRouteOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeleteRouteOutput = .{};

    return result;
}
