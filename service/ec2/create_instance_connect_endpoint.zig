const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Ec2InstanceConnectEndpoint = @import("ec_2_instance_connect_endpoint.zig").Ec2InstanceConnectEndpoint;
const serde = @import("serde.zig");

/// Creates an EC2 Instance Connect Endpoint.
///
/// An EC2 Instance Connect Endpoint allows you to connect to an instance,
/// without
/// requiring the instance to have a public IPv4 or public IPv6 address. For
/// more
/// information, see [Connect to your instances using EC2 Instance Connect
/// Endpoint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect-Endpoint.html) in the
/// *Amazon EC2 User Guide*.
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
    /// **Note:**
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
    /// **Note:**
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateInstanceConnectEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateInstanceConnectEndpointInput, options: Options) !CreateInstanceConnectEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInstanceConnectEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateInstanceConnectEndpoint&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.preserve_client_ip) |v| {
        try body_buf.appendSlice(alloc, "&PreserveClientIp=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&SubnetId=");
    try appendUrlEncoded(alloc, &body_buf, input.subnet_id);
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
