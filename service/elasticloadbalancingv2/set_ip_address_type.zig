const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;

pub const SetIpAddressTypeInput = struct {
    /// The IP address type. Internal load balancers must use `ipv4`.
    ///
    /// [Application Load Balancers] The possible values are `ipv4` (IPv4
    /// addresses),
    /// `dualstack` (IPv4 and IPv6 addresses), and `dualstack-without-public-ipv4`
    /// (public IPv6 addresses and private IPv4 and IPv6 addresses).
    ///
    /// Application Load Balancer authentication supports IPv4 addresses only when
    /// connecting to an Identity Provider (IdP) or Amazon Cognito endpoint. Without
    /// a public
    /// IPv4 address the load balancer can't complete the authentication process,
    /// resulting
    /// in HTTP 500 errors.
    ///
    /// [Network Load Balancers and Gateway Load Balancers] The possible values are
    /// `ipv4`
    /// (IPv4 addresses) and `dualstack` (IPv4 and IPv6 addresses).
    ip_address_type: IpAddressType,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: []const u8,
};

pub const SetIpAddressTypeOutput = struct {
    /// The IP address type.
    ip_address_type: ?IpAddressType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIpAddressTypeInput, options: CallOptions) !SetIpAddressTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIpAddressTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIpAddressType&Version=2015-12-01");
    try body_buf.appendSlice(allocator, "&IpAddressType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ip_address_type.wireName());
    try body_buf.appendSlice(allocator, "&LoadBalancerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIpAddressTypeOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SetIpAddressTypeResult")) break;
            },
            else => {},
        }
    }

    var result: SetIpAddressTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
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
