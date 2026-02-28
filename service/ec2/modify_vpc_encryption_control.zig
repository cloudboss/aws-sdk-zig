const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpcEncryptionControlExclusionStateInput = @import("vpc_encryption_control_exclusion_state_input.zig").VpcEncryptionControlExclusionStateInput;
const VpcEncryptionControlMode = @import("vpc_encryption_control_mode.zig").VpcEncryptionControlMode;
const VpcEncryptionControl = @import("vpc_encryption_control.zig").VpcEncryptionControl;
const serde = @import("serde.zig");

pub const ModifyVpcEncryptionControlInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether to exclude egress-only internet gateway traffic from
    /// encryption enforcement.
    egress_only_internet_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// Specifies whether to exclude Elastic File System traffic from encryption
    /// enforcement.
    elastic_file_system_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// Specifies whether to exclude internet gateway traffic from encryption
    /// enforcement.
    internet_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// Specifies whether to exclude Lambda function traffic from encryption
    /// enforcement.
    lambda_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// The encryption mode for the VPC Encryption Control configuration.
    mode: ?VpcEncryptionControlMode = null,

    /// Specifies whether to exclude NAT gateway traffic from encryption
    /// enforcement.
    nat_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// Specifies whether to exclude virtual private gateway traffic from encryption
    /// enforcement.
    virtual_private_gateway_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// The ID of the VPC Encryption Control resource to modify.
    vpc_encryption_control_id: []const u8,

    /// Specifies whether to exclude VPC Lattice traffic from encryption
    /// enforcement.
    vpc_lattice_exclusion: ?VpcEncryptionControlExclusionStateInput = null,

    /// Specifies whether to exclude VPC peering connection traffic from encryption
    /// enforcement.
    vpc_peering_exclusion: ?VpcEncryptionControlExclusionStateInput = null,
};

pub const ModifyVpcEncryptionControlOutput = struct {
    /// Information about the VPC Encryption Control configuration.
    vpc_encryption_control: ?VpcEncryptionControl = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpcEncryptionControlInput, options: Options) !ModifyVpcEncryptionControlOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcEncryptionControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcEncryptionControl&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.egress_only_internet_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&EgressOnlyInternetGatewayExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.elastic_file_system_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&ElasticFileSystemExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.internet_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&InternetGatewayExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.lambda_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&LambdaExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.mode) |v| {
        try body_buf.appendSlice(alloc, "&Mode=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.nat_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&NatGatewayExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.virtual_private_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VirtualPrivateGatewayExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&VpcEncryptionControlId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpc_encryption_control_id);
    if (input.vpc_lattice_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VpcLatticeExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.vpc_peering_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VpcPeeringExclusion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpcEncryptionControlOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcEncryptionControlOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpcEncryptionControl")) {
                    result.vpc_encryption_control = try serde.deserializeVpcEncryptionControl(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
