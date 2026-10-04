const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;
const serde = @import("serde.zig");

pub const CreateEndpointAccessInput = struct {
    /// The cluster identifier of the cluster to access.
    cluster_identifier: ?[]const u8 = null,

    /// The Redshift-managed VPC endpoint name.
    ///
    /// An endpoint name must contain 1-30 characters.
    /// Valid characters are A-Z, a-z, 0-9, and hyphen(-).
    /// The first character must be a letter.
    /// The name can't contain two consecutive hyphens or end with a hyphen.
    endpoint_name: []const u8,

    /// The Amazon Web Services account ID of the owner of the cluster. This is only
    /// required if the cluster is in another Amazon Web Services account.
    resource_owner: ?[]const u8 = null,

    /// The subnet group from which Amazon Redshift chooses the subnet to deploy the
    /// endpoint.
    subnet_group_name: []const u8,

    /// The security group that defines the ports, protocols, and sources for
    /// inbound traffic that you are authorizing into your endpoint.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateEndpointAccessOutput = @import("endpoint_access.zig").EndpointAccess;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointAccessInput, options: CallOptions) !CreateEndpointAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateEndpointAccess&Version=2012-12-01");
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&EndpointName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.endpoint_name);
    if (input.resource_owner) |v| {
        try body_buf.appendSlice(allocator, "&ResourceOwner=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SubnetGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.subnet_group_name);
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.VpcSecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointAccessOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateEndpointAccessResult")) break;
            },
            else => {},
        }
    }

    var result: CreateEndpointAccessOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Address")) {
                    result.address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointCreateTime")) {
                    result.endpoint_create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EndpointName")) {
                    result.endpoint_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointStatus")) {
                    result.endpoint_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Port")) {
                    result.port = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceOwner")) {
                    result.resource_owner = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubnetGroupName")) {
                    result.subnet_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcEndpoint")) {
                    result.vpc_endpoint = try serde.deserializeVpcEndpoint(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "VpcSecurityGroups")) {
                    result.vpc_security_groups = try serde.deserializeVpcSecurityGroupMembershipList(allocator, &reader, "VpcSecurityGroup");
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
