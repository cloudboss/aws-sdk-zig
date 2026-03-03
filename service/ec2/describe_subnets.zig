const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Subnet = @import("subnet.zig").Subnet;
const serde = @import("serde.zig");

pub const DescribeSubnetsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `availability-zone` - The Availability Zone for the subnet. You can also
    ///   use
    /// `availabilityZone` as the filter name.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone for the subnet.
    /// You can also use `availabilityZoneId` as the filter name.
    ///
    /// * `available-ip-address-count` - The number of IPv4 addresses in the
    /// subnet that are available.
    ///
    /// * `cidr-block` - The IPv4 CIDR block of the subnet. The CIDR block
    /// you specify must exactly match the subnet's CIDR block for information to be
    /// returned for the subnet. You can also use `cidr` or
    /// `cidrBlock` as the filter names.
    ///
    /// * `customer-owned-ipv4-pool` - The customer-owned IPv4 address pool
    /// associated with the subnet.
    ///
    /// * `default-for-az` - Indicates whether this is the default subnet for
    /// the Availability Zone (`true` | `false`). You can also use
    /// `defaultForAz` as the filter name.
    ///
    /// * `enable-dns64` - Indicates whether DNS queries made to the
    /// Amazon-provided DNS Resolver in this subnet should return synthetic IPv6
    /// addresses for IPv4-only destinations.
    ///
    /// * `enable-lni-at-device-index` - Indicates the device position for
    /// local network interfaces in this subnet. For example, `1` indicates
    /// local network interfaces in this subnet are the secondary network interface
    /// (eth1).
    ///
    /// * `ipv6-cidr-block-association.ipv6-cidr-block` - An IPv6 CIDR
    /// block associated with the subnet.
    ///
    /// * `ipv6-cidr-block-association.association-id` - An association ID
    /// for an IPv6 CIDR block associated with the subnet.
    ///
    /// * `ipv6-cidr-block-association.state` - The state of an IPv6 CIDR
    /// block associated with the subnet.
    ///
    /// * `ipv6-native` - Indicates whether this is an IPv6 only subnet
    /// (`true` | `false`).
    ///
    /// * `map-customer-owned-ip-on-launch` - Indicates whether a network
    /// interface created in this subnet (including a network interface created by
    /// RunInstances) receives a customer-owned IPv4 address.
    ///
    /// * `map-public-ip-on-launch` - Indicates whether instances launched in
    /// this subnet receive a public IPv4 address.
    ///
    /// * `outpost-arn` - The Amazon Resource Name (ARN) of the Outpost.
    ///
    /// * `owner-id` - The ID of the Amazon Web Services account that owns the
    /// subnet.
    ///
    /// * `private-dns-name-options-on-launch.hostname-type` - The type of
    /// hostname to assign to instances in the subnet at launch. For IPv4-only and
    /// dual-stack (IPv4 and IPv6) subnets, an instance DNS name can be based on the
    /// instance IPv4 address (ip-name) or the instance ID (resource-name). For IPv6
    /// only subnets, an instance DNS name must be based on the instance ID
    /// (resource-name).
    ///
    /// * `private-dns-name-options-on-launch.enable-resource-name-dns-a-record`
    /// - Indicates whether to respond to DNS queries for instance hostnames with
    /// DNS A
    /// records.
    ///
    /// * `private-dns-name-options-on-launch.enable-resource-name-dns-aaaa-record`
    /// - Indicates whether to respond to DNS queries for instance hostnames with
    /// DNS
    /// AAAA records.
    ///
    /// * `state` - The state of the subnet (`pending` | `available`).
    ///
    /// * `subnet-arn` - The Amazon Resource Name (ARN) of the subnet.
    ///
    /// * `subnet-id` - The ID of the subnet.
    ///
    /// * `tag` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `vpc-id` - The ID of the VPC for the subnet.
    filters: ?[]const Filter = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The IDs of the subnets.
    ///
    /// Default: Describes all your subnets.
    subnet_ids: ?[]const []const u8 = null,
};

pub const DescribeSubnetsOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// Information about the subnets.
    subnets: ?[]const Subnet = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSubnetsInput, options: Options) !DescribeSubnetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSubnetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeSubnets&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetId.SubnetId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSubnetsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSubnetsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "subnetSet")) {
                    result.subnets = try serde.deserializeSubnetList(allocator, &reader, "item");
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
