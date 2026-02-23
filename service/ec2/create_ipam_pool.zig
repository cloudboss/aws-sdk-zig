const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddressFamily = @import("address_family.zig").AddressFamily;
const RequestIpamResourceTag = @import("request_ipam_resource_tag.zig").RequestIpamResourceTag;
const IpamPoolAwsService = @import("ipam_pool_aws_service.zig").IpamPoolAwsService;
const IpamPoolPublicIpSource = @import("ipam_pool_public_ip_source.zig").IpamPoolPublicIpSource;
const IpamPoolSourceResourceRequest = @import("ipam_pool_source_resource_request.zig").IpamPoolSourceResourceRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamPool = @import("ipam_pool.zig").IpamPool;
const serde = @import("serde.zig");

pub const CreateIpamPoolInput = struct {
    /// The IP protocol assigned to this IPAM pool. You must choose either IPv4 or
    /// IPv6 protocol for a pool.
    address_family: AddressFamily,

    /// The default netmask length for allocations added to this pool. If, for
    /// example, the CIDR assigned to this pool is 10.0.0.0/8 and you enter 16 here,
    /// new allocations will default to 10.0.0.0/16.
    allocation_default_netmask_length: ?i32 = null,

    /// The maximum netmask length possible for CIDR allocations in this IPAM pool
    /// to be compliant. The maximum netmask length must be
    /// greater than the minimum netmask length. Possible netmask lengths for IPv4
    /// addresses are 0 - 32. Possible netmask lengths for IPv6 addresses are 0 -
    /// 128.
    allocation_max_netmask_length: ?i32 = null,

    /// The minimum netmask length required for CIDR allocations in this IPAM pool
    /// to be compliant. The minimum netmask length must be
    /// less than the maximum netmask length. Possible netmask lengths for IPv4
    /// addresses are 0 - 32. Possible netmask lengths for IPv6 addresses are 0 -
    /// 128.
    allocation_min_netmask_length: ?i32 = null,

    /// Tags that are required for resources that use CIDRs from this IPAM pool.
    /// Resources that do not have these tags will not be allowed to allocate space
    /// from the pool. If the resources have their tags changed after they have
    /// allocated space or if the allocation tagging requirements are changed on the
    /// pool, the resource may be marked as noncompliant.
    allocation_resource_tags: ?[]const RequestIpamResourceTag = null,

    /// If selected, IPAM will continuously look for resources within the CIDR range
    /// of this pool
    /// and automatically import them as allocations into your IPAM. The CIDRs that
    /// will be allocated for
    /// these resources must not already be allocated to other resources in order
    /// for the import to succeed. IPAM will import
    /// a CIDR regardless of its compliance with the pool's allocation rules, so a
    /// resource might be imported and subsequently
    /// marked as noncompliant. If IPAM discovers multiple CIDRs that overlap, IPAM
    /// will import the largest CIDR only. If IPAM
    /// discovers multiple CIDRs with matching CIDRs, IPAM will randomly import one
    /// of them only.
    ///
    /// A locale must be set on the pool for this feature to work.
    auto_import: ?bool = null,

    /// Limits which service in Amazon Web Services that the pool can be used in.
    /// "ec2", for example, allows users to use space for Elastic IP addresses and
    /// VPCs.
    aws_service: ?IpamPoolAwsService = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the IPAM pool.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the scope in which you would like to create the IPAM pool.
    ipam_scope_id: []const u8,

    /// The locale for the pool should be one of the following:
    ///
    /// * An Amazon Web Services Region where you want this IPAM pool to be
    ///   available for allocations.
    ///
    /// * The network border group for an Amazon Web Services Local Zone where you
    ///   want this IPAM pool to be available for allocations ([supported Local
    ///   Zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html#byoip-zone-avail)). This option is only available for IPAM IPv4 pools in the public scope.
    ///
    /// Possible values: Any Amazon Web Services Region or supported Amazon Web
    /// Services Local Zone. Default is `none` and means any locale.
    locale: ?[]const u8 = null,

    /// The IP address source for pools in the public scope. Only used for
    /// provisioning IP address CIDRs to pools in the public scope. Default is
    /// `byoip`. For more information, see [Create IPv6
    /// pools](https://docs.aws.amazon.com/vpc/latest/ipam/intro-create-ipv6-pools.html) in the *Amazon VPC IPAM User Guide*.
    /// By default, you can add only one Amazon-provided IPv6 CIDR block to a
    /// top-level IPv6 pool if PublicIpSource is `amazon`. For information on
    /// increasing the default limit, see [ Quotas for your
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    public_ip_source: ?IpamPoolPublicIpSource = null,

    /// Determines if the pool is publicly advertisable. The request can only
    /// contain `PubliclyAdvertisable` if `AddressFamily` is `ipv6` and
    /// `PublicIpSource` is `byoip`.
    publicly_advertisable: ?bool = null,

    /// The ID of the source IPAM pool. Use this option to create a pool within an
    /// existing pool. Note that the CIDR you provision for the pool within the
    /// source pool must be available in the source pool's CIDR range.
    source_ipam_pool_id: ?[]const u8 = null,

    /// The resource used to provision CIDRs to a resource planning pool.
    source_resource: ?IpamPoolSourceResourceRequest = null,

    /// The key/value combination of a tag assigned to the resource. Use the tag key
    /// in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateIpamPoolOutput = struct {
    /// Information about the IPAM pool created.
    ipam_pool: ?IpamPool = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIpamPoolInput, options: Options) !CreateIpamPoolOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIpamPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateIpamPool&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AddressFamily=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.address_family));
    if (input.allocation_default_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationDefaultNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.allocation_max_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationMaxNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.allocation_min_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationMinNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.allocation_resource_tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllocationResourceTag.item.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllocationResourceTag.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.auto_import) |v| {
        try body_buf.appendSlice(alloc, "&AutoImport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.aws_service) |v| {
        try body_buf.appendSlice(alloc, "&AwsService=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamScopeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.ipam_scope_id);
    if (input.locale) |v| {
        try body_buf.appendSlice(alloc, "&Locale=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.public_ip_source) |v| {
        try body_buf.appendSlice(alloc, "&PublicIpSource=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.publicly_advertisable) |v| {
        try body_buf.appendSlice(alloc, "&PubliclyAdvertisable=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.source_ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&SourceIpamPoolId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_resource) |v| {
        if (v.resource_id) |sv| {
            try body_buf.appendSlice(alloc, "&SourceResource.ResourceId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.resource_owner) |sv| {
            try body_buf.appendSlice(alloc, "&SourceResource.ResourceOwner=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.resource_region) |sv| {
            try body_buf.appendSlice(alloc, "&SourceResource.ResourceRegion=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.resource_type) |sv| {
            try body_buf.appendSlice(alloc, "&SourceResource.ResourceType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIpamPoolOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateIpamPoolOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPool")) {
                    result.ipam_pool = try serde.deserializeIpamPool(&reader, alloc);
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
