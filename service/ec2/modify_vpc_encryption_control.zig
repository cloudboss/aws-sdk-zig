const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpcEncryptionControlExclusionStateInput = @import("vpc_encryption_control_exclusion_state_input.zig").VpcEncryptionControlExclusionStateInput;
const VpcEncryptionControlMode = @import("vpc_encryption_control_mode.zig").VpcEncryptionControlMode;
const VpcEncryptionControl = @import("vpc_encryption_control.zig").VpcEncryptionControl;

/// Modifies the encryption control configuration for a VPC. You can update the
/// encryption mode and exclusion settings for various gateway types and peering
/// connections.
///
/// For more information, see [Enforce VPC encryption in
/// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyVpcEncryptionControlOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpcEncryptionControlInput, options: Options) !ModifyVpcEncryptionControlOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcEncryptionControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcEncryptionControl&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.egress_only_internet_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&EgressOnlyInternetGatewayExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.elastic_file_system_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&ElasticFileSystemExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.internet_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&InternetGatewayExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.lambda_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&LambdaExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.mode) |v| {
        try body_buf.appendSlice(alloc, "&Mode=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.nat_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&NatGatewayExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.virtual_private_gateway_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VirtualPrivateGatewayExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&VpcEncryptionControlId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpc_encryption_control_id);
    if (input.vpc_lattice_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VpcLatticeExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.vpc_peering_exclusion) |v| {
        try body_buf.appendSlice(alloc, "&VpcPeeringExclusion=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyVpcEncryptionControlOutput {
    _ = status;
    _ = body;
    const result: ModifyVpcEncryptionControlOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
