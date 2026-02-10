const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Tag = @import("tag.zig").Tag;

/// Creates a security group.
///
/// A security group acts as a virtual firewall for your instance to control
/// inbound and outbound traffic.
/// For more information, see
/// [Amazon EC2 security
/// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html) in
/// the *Amazon EC2 User Guide* and
/// [Security groups for your
/// VPC](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) in the
/// *Amazon VPC User Guide*.
///
/// When you create a security group, you specify a friendly name of your
/// choice.
/// You can't have two security groups for the same VPC with the same name.
///
/// You have a default security group for use in your VPC. If you don't specify
/// a security group
/// when you launch an instance, the instance is launched into the appropriate
/// default security group.
/// A default security group includes a default rule that grants instances
/// unrestricted network access
/// to each other.
///
/// You can add or remove rules from your security groups using
/// AuthorizeSecurityGroupIngress,
/// AuthorizeSecurityGroupEgress,
/// RevokeSecurityGroupIngress, and
/// RevokeSecurityGroupEgress.
///
/// For more information about VPC security group limits, see [Amazon VPC
/// Limits](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html).
pub const CreateSecurityGroupInput = struct {
    /// A description for the security group.
    ///
    /// Constraints: Up to 255 characters in length
    ///
    /// Valid characters: a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
    description: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The name of the security group. Names are case-insensitive and must be
    /// unique within the VPC.
    ///
    /// Constraints: Up to 255 characters in length. Can't start with `sg-`.
    ///
    /// Valid characters: a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
    group_name: []const u8,

    /// The tags to assign to the security group.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the VPC. Required for a nondefault VPC.
    vpc_id: ?[]const u8 = null,
};

pub const CreateSecurityGroupOutput = struct {
    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The security group ARN.
    security_group_arn: ?[]const u8 = null,

    /// The tags assigned to the security group.
    tags: ?[]const Tag = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateSecurityGroupOutput) void {
        if (self.group_id) |v| {
            self.allocator.free(v);
        }
        if (self.security_group_arn) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateSecurityGroupInput, options: Options) !CreateSecurityGroupOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSecurityGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateSecurityGroup&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Description=");
    try appendUrlEncoded(alloc, &body_buf, input.description);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&GroupName=");
    try appendUrlEncoded(alloc, &body_buf, input.group_name);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateSecurityGroupOutput {
    _ = status;
    var result: CreateSecurityGroupOutput = .{ .allocator = alloc };
    if (findElement(body, "groupId")) |content| {
        result.group_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "securityGroupArn")) |content| {
        result.security_group_arn = try alloc.dupe(u8, content);
    }

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
