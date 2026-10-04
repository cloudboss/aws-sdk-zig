const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterSecurityGroup = @import("cluster_security_group.zig").ClusterSecurityGroup;
const serde = @import("serde.zig");

pub const AuthorizeClusterSecurityGroupIngressInput = struct {
    /// The IP range to be added the Amazon Redshift security group.
    cidrip: ?[]const u8 = null,

    /// The name of the security group to which the ingress rule is added.
    cluster_security_group_name: []const u8,

    /// The EC2 security group to be added the Amazon Redshift security group.
    ec2_security_group_name: ?[]const u8 = null,

    /// The Amazon Web Services account number of the owner of the security group
    /// specified by the
    /// *EC2SecurityGroupName* parameter. The Amazon Web Services Access Key ID is
    /// not an
    /// acceptable value.
    ///
    /// Example: `111122223333`
    ec2_security_group_owner_id: ?[]const u8 = null,
};

pub const AuthorizeClusterSecurityGroupIngressOutput = struct {
    cluster_security_group: ?ClusterSecurityGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AuthorizeClusterSecurityGroupIngressInput, options: CallOptions) !AuthorizeClusterSecurityGroupIngressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AuthorizeClusterSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AuthorizeClusterSecurityGroupIngress&Version=2012-12-01");
    if (input.cidrip) |v| {
        try body_buf.appendSlice(allocator, "&CIDRIP=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClusterSecurityGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_security_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AuthorizeClusterSecurityGroupIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthorizeClusterSecurityGroupIngressResult")) break;
            },
            else => {},
        }
    }

    var result: AuthorizeClusterSecurityGroupIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClusterSecurityGroup")) {
                    result.cluster_security_group = try serde.deserializeClusterSecurityGroup(allocator, &reader);
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
