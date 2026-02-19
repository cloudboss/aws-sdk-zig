const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const serde = @import("serde.zig");

pub const ModifyInstanceConnectEndpointInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the EC2 Instance Connect Endpoint to modify.
    instance_connect_endpoint_id: []const u8,

    /// The new IP address type for the EC2 Instance Connect Endpoint.
    ///
    /// `PreserveClientIp` is only supported on IPv4 EC2 Instance Connect
    /// Endpoints. To use `PreserveClientIp`, the value for
    /// `IpAddressType` must be `ipv4`.
    ip_address_type: ?IpAddressType = null,

    /// Indicates whether the client IP address is preserved as the source when you
    /// connect to a resource.
    /// The following are the possible values.
    ///
    /// * `true` - Use the IP address of the client. Your instance must have an IPv4
    ///   address.
    ///
    /// * `false` - Use the IP address of the network interface.
    preserve_client_ip: ?bool = null,

    /// Changes the security groups for the EC2 Instance Connect Endpoint. The new
    /// set of
    /// groups you specify replaces the current set. You must specify at least one
    /// group, even
    /// if it's just the default security group in the VPC. You must specify the ID
    /// of the
    /// security group, not the name.
    security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyInstanceConnectEndpointOutput = struct {
    /// Is `true` if the request succeeds and an error otherwise.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstanceConnectEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstanceConnectEndpointInput, options: Options) !ModifyInstanceConnectEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceConnectEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceConnectEndpoint&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceConnectEndpointId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_connect_endpoint_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstanceConnectEndpointOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstanceConnectEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
