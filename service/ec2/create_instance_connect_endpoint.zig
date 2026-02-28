const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Ec2InstanceConnectEndpoint = @import("ec_2_instance_connect_endpoint.zig").Ec2InstanceConnectEndpoint;
const serde = @import("serde.zig");

pub const CreateInstanceConnectEndpointInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IP address type of the endpoint.
    ///
    /// If no value is specified, the default value is determined by the IP address
    /// type of
    /// the subnet:
    ///
    /// * `dualstack` - If the subnet has both IPv4 and IPv6 CIDRs
    ///
    /// * `ipv4` - If the subnet has only IPv4 CIDRs
    ///
    /// * `ipv6` - If the subnet has only IPv6 CIDRs
    ///
    /// `PreserveClientIp` is only supported on IPv4 EC2 Instance Connect
    /// Endpoints. To use `PreserveClientIp`, the value for
    /// `IpAddressType` must be `ipv4`.
    ip_address_type: ?IpAddressType = null,

    /// Indicates whether the client IP address is preserved as the source. The
    /// following are the possible values.
    ///
    /// * `true` - Use the client IP address as the source.
    ///
    /// * `false` - Use the network interface IP address as the source.
    ///
    /// `PreserveClientIp` is only supported on IPv4 EC2 Instance Connect
    /// Endpoints. To use `PreserveClientIp`, the value for
    /// `IpAddressType` must be `ipv4`.
    ///
    /// Default: `false`
    preserve_client_ip: ?bool = null,

    /// One or more security groups to associate with the endpoint. If you don't
    /// specify a security group,
    /// the default security group for your VPC will be associated with the
    /// endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of the subnet in which to create the EC2 Instance Connect Endpoint.
    subnet_id: []const u8,

    /// The tags to apply to the EC2 Instance Connect Endpoint during creation.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateInstanceConnectEndpointOutput = struct {
    /// Unique, case-sensitive idempotency token provided by the client in the the
    /// request.
    client_token: ?[]const u8 = null,

    /// Information about the EC2 Instance Connect Endpoint.
    instance_connect_endpoint: ?Ec2InstanceConnectEndpoint = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceConnectEndpointInput, options: Options) !CreateInstanceConnectEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInstanceConnectEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateInstanceConnectEndpoint&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.preserve_client_ip) |v| {
        try body_buf.appendSlice(alloc, "&PreserveClientIp=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupId.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&SubnetId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.subnet_id);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInstanceConnectEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateInstanceConnectEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceConnectEndpoint")) {
                    result.instance_connect_endpoint = try serde.deserializeEc2InstanceConnectEndpoint(&reader, alloc);
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
