const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ReleaseAddressInput = struct {
    /// The allocation ID. This parameter is required.
    allocation_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The set of Availability Zones, Local Zones, or Wavelength Zones from which
    /// Amazon Web Services advertises
    /// IP addresses.
    ///
    /// If you provide an incorrect network border group, you receive an
    /// `InvalidAddress.NotFound` error.
    network_border_group: ?[]const u8 = null,

    /// Deprecated.
    public_ip: ?[]const u8 = null,
};

pub const ReleaseAddressOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReleaseAddressInput, options: CallOptions) !ReleaseAddressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReleaseAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ReleaseAddress&Version=2016-11-15");
    if (input.allocation_id) |v| {
        try body_buf.appendSlice(allocator, "&AllocationId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.network_border_group) |v| {
        try body_buf.appendSlice(allocator, "&NetworkBorderGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.public_ip) |v| {
        try body_buf.appendSlice(allocator, "&PublicIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReleaseAddressOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ReleaseAddressOutput = .{};

    return result;
}
