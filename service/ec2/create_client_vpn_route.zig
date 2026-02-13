const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ClientVpnRouteStatus = @import("client_vpn_route_status.zig").ClientVpnRouteStatus;
const serde = @import("serde.zig");

/// Adds a route to a network to a Client VPN endpoint. Each Client VPN endpoint
/// has a route table that describes the
/// available destination network routes. Each route in the route table
/// specifies the path for traﬃc to speciﬁc resources or networks.
pub const CreateClientVpnRouteInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The ID of the Client VPN endpoint to which to add the route.
    client_vpn_endpoint_id: []const u8,

    /// A brief description of the route.
    description: ?[]const u8 = null,

    /// The IPv4 address range, in CIDR notation, of the route destination. For
    /// example:
    ///
    /// * To add a route for Internet access, enter `0.0.0.0/0`
    ///
    /// * To add a route for a peered VPC, enter the peered VPC's IPv4 CIDR range
    ///
    /// * To add a route for an on-premises network, enter the Amazon Web Services
    ///   Site-to-Site VPN connection's IPv4 CIDR range
    ///
    /// * To add a route for the local network, enter the client CIDR range
    destination_cidr_block: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the subnet through which you want to route traffic. The specified
    /// subnet must be
    /// an existing target network of the Client VPN endpoint.
    ///
    /// Alternatively, if you're adding a route for the local network, specify
    /// `local`.
    target_vpc_subnet_id: []const u8,
};

pub const CreateClientVpnRouteOutput = struct {
    /// The current state of the route.
    status: ?ClientVpnRouteStatus = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateClientVpnRouteOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateClientVpnRouteInput, options: Options) !CreateClientVpnRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateClientVpnRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateClientVpnRoute&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&ClientVpnEndpointId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.client_vpn_endpoint_id);
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.destination_cidr_block);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&TargetVpcSubnetId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.target_vpc_subnet_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateClientVpnRouteOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateClientVpnRouteOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "status")) {
                    result.status = try serde.deserializeClientVpnRouteStatus(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
