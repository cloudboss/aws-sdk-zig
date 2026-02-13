const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const serde = @import("serde.zig");

/// Describes the specified network interfaces or all your network interfaces.
///
/// If you have a large number of network interfaces, the operation fails unless
/// you use
/// pagination or one of the following filters: `group-id`,
/// `mac-address`, `private-dns-name`,
/// `private-ip-address`, `subnet-id`, or
/// `vpc-id`.
///
/// **Important:**
///
/// We strongly recommend using only paginated requests. Unpaginated requests
/// are
/// susceptible to throttling and timeouts.
pub const DescribeNetworkInterfacesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters.
    ///
    /// * `association.allocation-id` - The allocation ID returned when you
    /// allocated the Elastic IP address (IPv4) for your network interface.
    ///
    /// * `association.association-id` - The association ID returned when the
    /// network interface was associated with an IPv4 address.
    ///
    /// * `addresses.association.owner-id` - The owner ID of the addresses
    /// associated with the network interface.
    ///
    /// * `addresses.association.public-ip` - The association ID returned
    /// when the network interface was associated with the Elastic IP address
    /// (IPv4).
    ///
    /// * `addresses.primary` - Whether the private IPv4 address is the
    /// primary IP address associated with the network interface.
    ///
    /// * `addresses.private-ip-address` - The private IPv4 addresses
    /// associated with the network interface.
    ///
    /// * `association.ip-owner-id` - The owner of the Elastic IP address
    /// (IPv4) associated with the network interface.
    ///
    /// * `association.public-ip` - The address of the Elastic IP address
    /// (IPv4) bound to the network interface.
    ///
    /// * `association.public-dns-name` - The public DNS name for the network
    /// interface (IPv4).
    ///
    /// * `attachment.attach-time` - The time that the network interface was
    /// attached to an instance.
    ///
    /// * `attachment.attachment-id` - The ID of the interface
    /// attachment.
    ///
    /// * `attachment.delete-on-termination` - Indicates whether the
    /// attachment is deleted when an instance is terminated.
    ///
    /// * `attachment.device-index` - The device index to which the network
    /// interface is attached.
    ///
    /// * `attachment.instance-id` - The ID of the instance to which the
    /// network interface is attached.
    ///
    /// * `attachment.instance-owner-id` - The owner ID of the instance to
    /// which the network interface is attached.
    ///
    /// * `attachment.status` - The status of the attachment
    /// (`attaching` | `attached` | `detaching` |
    /// `detached`).
    ///
    /// * `availability-zone` - The Availability Zone of the network
    /// interface.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone of the
    /// network interface.
    ///
    /// * `description` - The description of the network interface.
    ///
    /// * `group-id` - The ID of a security group associated with the network
    /// interface.
    ///
    /// * `ipv6-addresses.ipv6-address` - An IPv6 address associated with the
    /// network interface.
    ///
    /// * `interface-type` - The type of network interface
    /// (`api_gateway_managed` |
    /// `aws_codestar_connections_managed` | `branch` |
    /// `ec2_instance_connect_endpoint` | `efa` |
    /// `efa-only` | `efs` |
    /// `evs` |
    /// `gateway_load_balancer` |
    /// `gateway_load_balancer_endpoint` |
    /// `global_accelerator_managed` | `interface` |
    /// `iot_rules_managed` | `lambda` |
    /// `load_balancer` | `nat_gateway` |
    /// `network_load_balancer` | `quicksight` |
    /// `transit_gateway` | `trunk` |
    /// `vpc_endpoint`).
    ///
    /// * `mac-address` - The MAC address of the network interface.
    ///
    /// * `network-interface-id` - The ID of the network interface.
    ///
    /// * `operator.managed` - A Boolean that indicates whether this is a
    /// managed network interface.
    ///
    /// * `operator.principal` - The principal that manages the network
    /// interface. Only valid for managed network interfaces, where `managed`
    /// is `true`.
    ///
    /// * `owner-id` - The Amazon Web Services account ID of the network
    /// interface owner.
    ///
    /// * `private-dns-name` - The private DNS name of the network interface
    /// (IPv4).
    ///
    /// * `private-ip-address` - The private IPv4 address or addresses of the
    /// network interface.
    ///
    /// * `requester-id` - The alias or Amazon Web Services account ID of the
    /// principal or service that created the network interface.
    ///
    /// * `requester-managed` - Indicates whether the network interface is
    /// being managed by an Amazon Web Services service (for example, Amazon Web
    /// Services Management Console, Auto Scaling, and so on).
    ///
    /// * `source-dest-check` - Indicates whether the network interface
    /// performs source/destination checking. A value of `true` means
    /// checking is enabled, and `false` means checking is disabled. The
    /// value must be `false` for the network interface to perform network
    /// address translation (NAT) in your VPC.
    ///
    /// * `status` - The status of the network interface. If the network
    /// interface is not attached to an instance, the status is `available`;
    /// if a network interface is attached to an instance the status is
    /// `in-use`.
    ///
    /// * `subnet-id` - The ID of the subnet for the network
    /// interface.
    ///
    /// * `tag`: - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `vpc-id` - The ID of the VPC for the network interface.
    filters: ?[]const Filter = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items,
    /// make another request with the token returned in the output. You cannot
    /// specify this
    /// parameter and the network interface IDs parameter in the same request. For
    /// more
    /// information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The network interface IDs.
    ///
    /// Default: Describes all your network interfaces.
    network_interface_ids: ?[]const []const u8 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the
    /// end of the items returned by the previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeNetworkInterfacesOutput = struct {
    /// Information about the network interfaces.
    network_interfaces: ?[]const NetworkInterface = null,

    /// The token to include in another request to get the next page of items. This
    /// value is
    /// `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeNetworkInterfacesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeNetworkInterfacesInput, options: Options) !DescribeNetworkInterfacesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeNetworkInterfacesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeNetworkInterfaces&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.network_interface_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeNetworkInterfacesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeNetworkInterfacesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "networkInterfaceSet")) {
                    result.network_interfaces = try serde.deserializeNetworkInterfaceList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
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
