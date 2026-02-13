const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NatGatewayAddress = @import("nat_gateway_address.zig").NatGatewayAddress;
const serde = @import("serde.zig");

/// Disassociates secondary Elastic IP addresses (EIPs) from a public NAT
/// gateway.
/// You cannot disassociate your primary EIP. For more information, see [Edit
/// secondary IP address
/// associations](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html#nat-gateway-edit-secondary) in the *Amazon VPC User Guide*.
///
/// While disassociating is in progress, you cannot associate/disassociate
/// additional EIPs while the connections are being drained. You are, however,
/// allowed to delete the NAT gateway.
///
/// An EIP is released only at the end of MaxDrainDurationSeconds. It stays
/// associated and supports the existing connections but does not support any
/// new connections
/// (new connections are distributed across the remaining associated EIPs). As
/// the existing
/// connections drain out, the EIPs (and the corresponding private IP addresses
/// mapped to them)
/// are released.
pub const DisassociateNatGatewayAddressInput = struct {
    /// The association IDs of EIPs that have been associated with the NAT gateway.
    association_ids: []const []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The maximum amount of time to wait (in seconds) before forcibly releasing
    /// the IP addresses if connections are still in progress. Default value is 350
    /// seconds.
    max_drain_duration_seconds: ?i32 = null,

    /// The ID of the NAT gateway.
    nat_gateway_id: []const u8,
};

pub const DisassociateNatGatewayAddressOutput = struct {
    /// Information about the NAT gateway IP addresses.
    nat_gateway_addresses: ?[]const NatGatewayAddress = null,

    /// The ID of the NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DisassociateNatGatewayAddressOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DisassociateNatGatewayAddressInput, options: Options) !DisassociateNatGatewayAddressOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DisassociateNatGatewayAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DisassociateNatGatewayAddress&Version=2016-11-15");
    for (input.association_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssociationIds.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.max_drain_duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&MaxDrainDurationSeconds=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&NatGatewayId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.nat_gateway_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DisassociateNatGatewayAddressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DisassociateNatGatewayAddressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "natGatewayAddressSet")) {
                    result.nat_gateway_addresses = try serde.deserializeNatGatewayAddressList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "natGatewayId")) {
                    result.nat_gateway_id = try alloc.dupe(u8, try reader.readElementText());
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
