const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBSecurityGroup = @import("db_security_group.zig").DBSecurityGroup;
const serde = @import("serde.zig");

pub const RevokeDBSecurityGroupIngressInput = struct {
    /// The IP range to revoke access from. Must be a valid CIDR range. If `CIDRIP`
    /// is specified, `EC2SecurityGroupName`, `EC2SecurityGroupId` and
    /// `EC2SecurityGroupOwnerId` can't be provided.
    cidrip: ?[]const u8 = null,

    /// The name of the DB security group to revoke ingress from.
    db_security_group_name: []const u8,

    /// The id of the EC2 security group to revoke access from. For VPC DB security
    /// groups, `EC2SecurityGroupId` must be provided. Otherwise,
    /// EC2SecurityGroupOwnerId and either `EC2SecurityGroupName` or
    /// `EC2SecurityGroupId` must be provided.
    ec2_security_group_id: ?[]const u8 = null,

    /// The name of the EC2 security group to revoke access from. For VPC DB
    /// security groups, `EC2SecurityGroupId` must be provided. Otherwise,
    /// EC2SecurityGroupOwnerId and either `EC2SecurityGroupName` or
    /// `EC2SecurityGroupId` must be provided.
    ec2_security_group_name: ?[]const u8 = null,

    /// The Amazon Web Services account number of the owner of the EC2 security
    /// group specified in the `EC2SecurityGroupName` parameter. The Amazon Web
    /// Services access key ID isn't an acceptable value. For VPC DB security
    /// groups, `EC2SecurityGroupId` must be provided. Otherwise,
    /// EC2SecurityGroupOwnerId and either `EC2SecurityGroupName` or
    /// `EC2SecurityGroupId` must be provided.
    ec2_security_group_owner_id: ?[]const u8 = null,
};

pub const RevokeDBSecurityGroupIngressOutput = struct {
    db_security_group: ?DBSecurityGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeDBSecurityGroupIngressInput, options: CallOptions) !RevokeDBSecurityGroupIngressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeDBSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RevokeDBSecurityGroupIngress&Version=2014-10-31");
    if (input.cidrip) |v| {
        try body_buf.appendSlice(allocator, "&CIDRIP=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBSecurityGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_security_group_name);
    if (input.ec2_security_group_id) |v| {
        try body_buf.appendSlice(allocator, "&EC2SecurityGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ec2_security_group_name) |v| {
        try body_buf.appendSlice(allocator, "&EC2SecurityGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ec2_security_group_owner_id) |v| {
        try body_buf.appendSlice(allocator, "&EC2SecurityGroupOwnerId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeDBSecurityGroupIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RevokeDBSecurityGroupIngressResult")) break;
            },
            else => {},
        }
    }

    var result: RevokeDBSecurityGroupIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSecurityGroup")) {
                    result.db_security_group = try serde.deserializeDBSecurityGroup(allocator, &reader);
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
