const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpcCidrBlockAssociation = @import("vpc_cidr_block_association.zig").VpcCidrBlockAssociation;
const VpcIpv6CidrBlockAssociation = @import("vpc_ipv_6_cidr_block_association.zig").VpcIpv6CidrBlockAssociation;
const serde = @import("serde.zig");

pub const DisassociateVpcCidrBlockInput = struct {
    /// The association ID for the CIDR block.
    association_id: []const u8,
};

pub const DisassociateVpcCidrBlockOutput = struct {
    /// Information about the IPv4 CIDR block association.
    cidr_block_association: ?VpcCidrBlockAssociation = null,

    /// Information about the IPv6 CIDR block association.
    ipv_6_cidr_block_association: ?VpcIpv6CidrBlockAssociation = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DisassociateVpcCidrBlockOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DisassociateVpcCidrBlockInput, options: Options) !DisassociateVpcCidrBlockOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DisassociateVpcCidrBlockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DisassociateVpcCidrBlock&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AssociationId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.association_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DisassociateVpcCidrBlockOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DisassociateVpcCidrBlockOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "cidrBlockAssociation")) {
                    result.cidr_block_association = try serde.deserializeVpcCidrBlockAssociation(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ipv6CidrBlockAssociation")) {
                    result.ipv_6_cidr_block_association = try serde.deserializeVpcIpv6CidrBlockAssociation(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "vpcId")) {
                    result.vpc_id = try alloc.dupe(u8, try reader.readElementText());
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
