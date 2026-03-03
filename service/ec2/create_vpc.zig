const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tenancy = @import("tenancy.zig").Tenancy;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VpcEncryptionControlConfiguration = @import("vpc_encryption_control_configuration.zig").VpcEncryptionControlConfiguration;
const Vpc = @import("vpc.zig").Vpc;
const serde = @import("serde.zig");

pub const CreateVpcInput = struct {
    /// Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the
    /// VPC.
    /// You cannot specify the range of IP addresses, or the size of the CIDR block.
    amazon_provided_ipv_6_cidr_block: ?bool = null,

    /// The IPv4 network range for the VPC, in CIDR notation. For example,
    /// `10.0.0.0/16`. We modify the specified CIDR block to its canonical form; for
    /// example, if you specify `100.68.0.18/18`, we modify it to `100.68.0.0/18`.
    cidr_block: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The tenancy options for instances launched into the VPC. For `default`,
    /// instances
    /// are launched with shared tenancy by default. You can launch instances with
    /// any tenancy into a
    /// shared tenancy VPC. For `dedicated`, instances are launched as dedicated
    /// tenancy
    /// instances by default. You can only launch instances with a tenancy of
    /// `dedicated`
    /// or `host` into a dedicated tenancy VPC.
    ///
    /// **Important:** The `host` value cannot be used with this parameter. Use the
    /// `default` or `dedicated` values only.
    ///
    /// Default: `default`
    instance_tenancy: ?Tenancy = null,

    /// The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR.
    /// For more information, see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_4_ipam_pool_id: ?[]const u8 = null,

    /// The netmask length of the IPv4 CIDR you want to allocate to this VPC from an
    /// Amazon VPC IP Address Manager (IPAM) pool. For more information about IPAM,
    /// see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_4_netmask_length: ?i32 = null,

    /// The IPv6 CIDR block from the IPv6 address pool. You must also specify
    /// `Ipv6Pool` in the request.
    ///
    /// To let Amazon choose the IPv6 CIDR block for you, omit this parameter.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// The name of the location from which we advertise the IPV6 CIDR block. Use
    /// this parameter to limit the address to this location.
    ///
    /// You must set `AmazonProvidedIpv6CidrBlock` to `true` to use this parameter.
    ipv_6_cidr_block_network_border_group: ?[]const u8 = null,

    /// The ID of an IPv6 IPAM pool which will be used to allocate this VPC an IPv6
    /// CIDR. IPAM is a VPC feature that you can use to automate your IP address
    /// management workflows including assigning, tracking, troubleshooting, and
    /// auditing IP addresses across Amazon Web Services Regions and accounts
    /// throughout your Amazon Web Services Organization. For more information, see
    /// [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_6_ipam_pool_id: ?[]const u8 = null,

    /// The netmask length of the IPv6 CIDR you want to allocate to this VPC from an
    /// Amazon VPC IP Address Manager (IPAM) pool. For more information about IPAM,
    /// see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_6_netmask_length: ?i32 = null,

    /// The ID of an IPv6 address pool from which to allocate the IPv6 CIDR block.
    ipv_6_pool: ?[]const u8 = null,

    /// The tags to assign to the VPC.
    tag_specifications: ?[]const TagSpecification = null,

    /// Specifies the encryption control configuration to apply to the VPC during
    /// creation. VPC Encryption Control enables you to enforce encryption for all
    /// data in transit within and between VPCs to meet compliance requirements.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    vpc_encryption_control: ?VpcEncryptionControlConfiguration = null,
};

pub const CreateVpcOutput = struct {
    /// Information about the VPC.
    vpc: ?Vpc = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcInput, options: Options) !CreateVpcOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateVpc&Version=2016-11-15");
    if (input.amazon_provided_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&AmazonProvidedIpv6CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_tenancy) |v| {
        try body_buf.appendSlice(allocator, "&InstanceTenancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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
    if (input.ipv_6_cidr_block_network_border_group) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6CidrBlockNetworkBorderGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_ipam_pool_id) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6IpamPoolId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_pool) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6Pool=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.vpc_encryption_control) |v| {
        if (v.egress_only_internet_gateway_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.EgressOnlyInternetGatewayExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.elastic_file_system_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.ElasticFileSystemExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.internet_gateway_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.InternetGatewayExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.lambda_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.LambdaExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        try body_buf.appendSlice(allocator, "&VpcEncryptionControl.Mode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v.mode));
        if (v.nat_gateway_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.NatGatewayExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.virtual_private_gateway_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.VirtualPrivateGatewayExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.vpc_lattice_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.VpcLatticeExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.vpc_peering_exclusion) |sv| {
            try body_buf.appendSlice(allocator, "&VpcEncryptionControl.VpcPeeringExclusion=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateVpcOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpc")) {
                    result.vpc = try serde.deserializeVpc(allocator, &reader);
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
