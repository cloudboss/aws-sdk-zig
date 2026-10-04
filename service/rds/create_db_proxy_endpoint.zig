const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointNetworkType = @import("endpoint_network_type.zig").EndpointNetworkType;
const Tag = @import("tag.zig").Tag;
const DBProxyEndpointTargetRole = @import("db_proxy_endpoint_target_role.zig").DBProxyEndpointTargetRole;
const DBProxyEndpoint = @import("db_proxy_endpoint.zig").DBProxyEndpoint;
const serde = @import("serde.zig");

pub const CreateDBProxyEndpointInput = struct {
    /// The name of the DB proxy endpoint to create.
    db_proxy_endpoint_name: []const u8,

    /// The name of the DB proxy associated with the DB proxy endpoint that you
    /// create.
    db_proxy_name: []const u8,

    /// The network type of the DB proxy endpoint. The network type determines the
    /// IP version that the proxy endpoint supports.
    ///
    /// Valid values:
    ///
    /// * `IPV4` - The proxy endpoint supports IPv4 only.
    /// * `IPV6` - The proxy endpoint supports IPv6 only.
    /// * `DUAL` - The proxy endpoint supports both IPv4 and IPv6.
    ///
    /// Default: `IPV4`
    ///
    /// Constraints:
    ///
    /// * If you specify `IPV6` or `DUAL`, the VPC and all subnets must have an IPv6
    ///   CIDR block.
    /// * If you specify `IPV6` or `DUAL`, the VPC tenancy cannot be `dedicated`.
    endpoint_network_type: ?EndpointNetworkType = null,

    tags: ?[]const Tag = null,

    /// The role of the DB proxy endpoint. The role determines whether the endpoint
    /// can be used for read/write or only read operations. The default is
    /// `READ_WRITE`. The only role that proxies for RDS for Microsoft SQL Server
    /// support is `READ_WRITE`.
    target_role: ?DBProxyEndpointTargetRole = null,

    /// The VPC security group IDs for the DB proxy endpoint that you create. You
    /// can specify a different set of security group IDs than for the original DB
    /// proxy. The default is the default security group for the VPC.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// The VPC subnet IDs for the DB proxy endpoint that you create. You can
    /// specify a different set of subnet IDs than for the original DB proxy.
    vpc_subnet_ids: []const []const u8,
};

pub const CreateDBProxyEndpointOutput = struct {
    /// The `DBProxyEndpoint` object that is created by the API operation. The DB
    /// proxy endpoint that you create might provide capabilities such as read/write
    /// or read-only operations, or using a different VPC than the proxy's default
    /// VPC.
    db_proxy_endpoint: ?DBProxyEndpoint = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBProxyEndpointInput, options: CallOptions) !CreateDBProxyEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBProxyEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBProxyEndpoint&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBProxyEndpointName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_proxy_endpoint_name);
    try body_buf.appendSlice(allocator, "&DBProxyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_proxy_name);
    if (input.endpoint_network_type) |v| {
        try body_buf.appendSlice(allocator, "&EndpointNetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_role) |v| {
        try body_buf.appendSlice(allocator, "&TargetRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    for (input.vpc_subnet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSubnetIds.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBProxyEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBProxyEndpointResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBProxyEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBProxyEndpoint")) {
                    result.db_proxy_endpoint = try serde.deserializeDBProxyEndpoint(allocator, &reader);
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
