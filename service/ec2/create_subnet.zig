const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Subnet = @import("subnet.zig").Subnet;
const serde = @import("serde.zig");

pub const CreateSubnetInput = struct {
    /// The Availability Zone or Local Zone for the subnet.
    ///
    /// Default: Amazon Web Services selects one for you. If you create more than
    /// one subnet in your VPC, we
    /// do not necessarily select a different zone for each subnet.
    ///
    /// To create a subnet in a Local Zone, set this value to the Local Zone ID, for
    /// example
    /// `us-west-2-lax-1a`. For information about the Regions that support Local
    /// Zones,
    /// see [Available Local
    /// Zones](https://docs.aws.amazon.com/local-zones/latest/ug/available-local-zones.html).
    ///
    /// To create a subnet in an Outpost, set this value to the Availability Zone
    /// for the
    /// Outpost and specify the Outpost ARN.
    availability_zone: ?[]const u8 = null,

    /// The AZ ID or the Local Zone ID of the subnet.
    availability_zone_id: ?[]const u8 = null,

    /// The IPv4 network range for the subnet, in CIDR notation. For example,
    /// `10.0.0.0/24`.
    /// We modify the specified CIDR block to its canonical form; for example, if
    /// you specify
    /// `100.68.0.18/18`, we modify it to `100.68.0.0/18`.
    ///
    /// This parameter is not supported for an IPv6 only subnet.
    cidr_block: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// An IPv4 IPAM pool ID for the subnet.
    ipv_4_ipam_pool_id: ?[]const u8 = null,

    /// An IPv4 netmask length for the subnet.
    ipv_4_netmask_length: ?i32 = null,

    /// The IPv6 network range for the subnet, in CIDR notation. This parameter is
    /// required
    /// for an IPv6 only subnet.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// An IPv6 IPAM pool ID for the subnet.
    ipv_6_ipam_pool_id: ?[]const u8 = null,

    /// Indicates whether to create an IPv6 only subnet.
    ipv_6_native: ?bool = null,

    /// An IPv6 netmask length for the subnet.
    ipv_6_netmask_length: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the Outpost. If you specify an Outpost
    /// ARN, you must also
    /// specify the Availability Zone of the Outpost subnet.
    outpost_arn: ?[]const u8 = null,

    /// The tags to assign to the subnet.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the VPC.
    vpc_id: []const u8,
};

pub const CreateSubnetOutput = struct {
    /// Information about the subnet.
    subnet: ?Subnet = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubnetInput, options: CallOptions) !CreateSubnetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubnetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateSubnet&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_4_ipam_pool_id) |v| {
        try body_buf.appendSlice(allocator, "&Ipv4IpamPoolId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_4_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&Ipv4NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_ipam_pool_id) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6IpamPoolId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_native) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6Native=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_6_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(allocator, "&OutpostArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&VpcId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpc_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubnetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateSubnetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "subnet")) {
                    result.subnet = try serde.deserializeSubnet(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
