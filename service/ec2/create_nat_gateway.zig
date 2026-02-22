const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityMode = @import("availability_mode.zig").AvailabilityMode;
const AvailabilityZoneAddress = @import("availability_zone_address.zig").AvailabilityZoneAddress;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NatGateway = @import("nat_gateway.zig").NatGateway;
const serde = @import("serde.zig");

pub const CreateNatGatewayInput = struct {
    /// [Public NAT gateways only] The allocation ID of an Elastic IP address to
    /// associate
    /// with the NAT gateway. You cannot specify an Elastic IP address with a
    /// private NAT gateway.
    /// If the Elastic IP address is associated with another resource, you must
    /// first disassociate it.
    allocation_id: ?[]const u8 = null,

    /// Specifies whether to create a zonal (single-AZ) or regional (multi-AZ) NAT
    /// gateway. Defaults to `zonal`.
    ///
    /// A zonal NAT gateway is a NAT Gateway that provides redundancy and
    /// scalability within a single availability zone. A regional NAT gateway is a
    /// single NAT Gateway that works across multiple availability zones (AZs) in
    /// your VPC, providing redundancy, scalability and availability across all the
    /// AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    availability_mode: ?AvailabilityMode = null,

    /// For regional NAT gateways only: Specifies which Availability Zones you want
    /// the NAT gateway to support and the Elastic IP addresses (EIPs) to use in
    /// each AZ. The regional NAT gateway uses these EIPs to handle outbound NAT
    /// traffic from their respective AZs. If not specified, the NAT gateway will
    /// automatically expand to new AZs and associate EIPs upon detection of an
    /// elastic network interface. If you specify this parameter, auto-expansion is
    /// disabled and you must manually manage AZ coverage.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    availability_zone_addresses: ?[]const AvailabilityZoneAddress = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    ///
    /// Constraint: Maximum 64 ASCII characters.
    client_token: ?[]const u8 = null,

    /// Indicates whether the NAT gateway supports public or private connectivity.
    /// The default is public connectivity.
    connectivity_type: ?ConnectivityType = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The private IPv4 address to assign to the NAT gateway. If you don't provide
    /// an address, a private IPv4 address will be automatically assigned.
    private_ip_address: ?[]const u8 = null,

    /// Secondary EIP allocation IDs. For more information, see [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html)
    /// in the *Amazon VPC User Guide*.
    secondary_allocation_ids: ?[]const []const u8 = null,

    /// [Private NAT gateway only] The number of secondary private IPv4 addresses
    /// you want to assign to the NAT gateway.
    /// For more information about secondary addresses, see [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html)
    /// in the *Amazon VPC User Guide*.
    secondary_private_ip_address_count: ?i32 = null,

    /// Secondary private IPv4 addresses. For more information about secondary
    /// addresses, see
    /// [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html) in the *Amazon VPC User Guide*.
    secondary_private_ip_addresses: ?[]const []const u8 = null,

    /// The ID of the subnet in which to create the NAT gateway.
    subnet_id: ?[]const u8 = null,

    /// The tags to assign to the NAT gateway.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the VPC where you want to create a regional NAT gateway.
    vpc_id: ?[]const u8 = null,
};

pub const CreateNatGatewayOutput = struct {
    /// Unique, case-sensitive identifier to ensure the idempotency of the request.
    /// Only returned if a client token was provided in the request.
    client_token: ?[]const u8 = null,

    /// Information about the NAT gateway.
    nat_gateway: ?NatGateway = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateNatGatewayOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateNatGatewayInput, options: Options) !CreateNatGatewayOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateNatGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateNatGateway&Version=2016-11-15");
    if (input.allocation_id) |v| {
        try body_buf.appendSlice(alloc, "&AllocationId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_mode) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityMode=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.availability_zone_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.allocation_ids) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneAddress.AvailabilityZoneAddress.{d}.AllocationIds.AllocationId.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneAddress.AvailabilityZoneAddress.{d}.AvailabilityZone=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.availability_zone) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneAddress.AvailabilityZoneAddress.{d}.AvailabilityZoneId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.availability_zone_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.connectivity_type) |v| {
        try body_buf.appendSlice(alloc, "&ConnectivityType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&PrivateIpAddress=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.secondary_allocation_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecondaryAllocationId.AllocationId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(alloc, "&SecondaryPrivateIpAddressCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.secondary_private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecondaryPrivateIpAddress.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.subnet_id) |v| {
        try body_buf.appendSlice(alloc, "&SubnetId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
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
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateNatGatewayOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateNatGatewayOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "natGateway")) {
                    result.nat_gateway = try serde.deserializeNatGateway(&reader, alloc);
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
