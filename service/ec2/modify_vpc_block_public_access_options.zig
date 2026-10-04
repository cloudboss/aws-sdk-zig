const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InternetGatewayBlockMode = @import("internet_gateway_block_mode.zig").InternetGatewayBlockMode;
const VpcBlockPublicAccessOptions = @import("vpc_block_public_access_options.zig").VpcBlockPublicAccessOptions;
const serde = @import("serde.zig");

pub const ModifyVpcBlockPublicAccessOptionsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The mode of VPC BPA.
    ///
    /// * `off`: VPC BPA is not enabled and traffic is allowed to and from internet
    ///   gateways and egress-only internet gateways in this Region.
    ///
    /// * `block-bidirectional`: Block all traffic to and from internet gateways and
    ///   egress-only internet gateways in this Region (except for excluded VPCs and
    ///   subnets).
    ///
    /// * `block-ingress`: Block all internet traffic to the VPCs in this Region
    ///   (except for VPCs or subnets which are excluded). Only traffic to and from
    ///   NAT gateways and egress-only internet gateways is allowed because these
    ///   gateways only allow outbound connections to be established.
    internet_gateway_block_mode: InternetGatewayBlockMode,
};

pub const ModifyVpcBlockPublicAccessOptionsOutput = struct {
    /// Details related to the VPC Block Public Access (BPA) options.
    vpc_block_public_access_options: ?VpcBlockPublicAccessOptions = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpcBlockPublicAccessOptionsInput, options: CallOptions) !ModifyVpcBlockPublicAccessOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVpcBlockPublicAccessOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyVpcBlockPublicAccessOptions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&InternetGatewayBlockMode=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.internet_gateway_block_mode.wireName());

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVpcBlockPublicAccessOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcBlockPublicAccessOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpcBlockPublicAccessOptions")) {
                    result.vpc_block_public_access_options = try serde.deserializeVpcBlockPublicAccessOptions(allocator, &reader);
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
