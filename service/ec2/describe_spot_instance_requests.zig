const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const SpotInstanceRequest = @import("spot_instance_request.zig").SpotInstanceRequest;
const serde = @import("serde.zig");

pub const DescribeSpotInstanceRequestsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `availability-zone-group` - The Availability Zone group.
    ///
    /// * `create-time` - The time stamp when the Spot Instance request was
    /// created.
    ///
    /// * `fault-code` - The fault code related to the request.
    ///
    /// * `fault-message` - The fault message related to the request.
    ///
    /// * `instance-id` - The ID of the instance that fulfilled the
    /// request.
    ///
    /// * `launch-group` - The Spot Instance launch group.
    ///
    /// * `launch.block-device-mapping.delete-on-termination` - Indicates
    /// whether the EBS volume is deleted on instance termination.
    ///
    /// * `launch.block-device-mapping.device-name` - The device name for the
    /// volume in the block device mapping (for example, `/dev/sdh` or
    /// `xvdh`).
    ///
    /// * `launch.block-device-mapping.snapshot-id` - The ID of the snapshot
    /// for the EBS volume.
    ///
    /// * `launch.block-device-mapping.volume-size` - The size of the EBS
    /// volume, in GiB.
    ///
    /// * `launch.block-device-mapping.volume-type` - The type of EBS volume:
    /// `gp2` or `gp3` for General Purpose SSD, `io1`
    /// or `io2` for Provisioned IOPS SSD, `st1` for Throughput
    /// Optimized HDD, `sc1` for Cold HDD, or `standard` for
    /// Magnetic.
    ///
    /// * `launch.group-id` - The ID of the security group for the
    /// instance.
    ///
    /// * `launch.group-name` - The name of the security group for the
    /// instance.
    ///
    /// * `launch.image-id` - The ID of the AMI.
    ///
    /// * `launch.instance-type` - The type of instance (for example,
    /// `m3.medium`).
    ///
    /// * `launch.kernel-id` - The kernel ID.
    ///
    /// * `launch.key-name` - The name of the key pair the instance launched
    /// with.
    ///
    /// * `launch.monitoring-enabled` - Whether detailed monitoring is
    /// enabled for the Spot Instance.
    ///
    /// * `launch.ramdisk-id` - The RAM disk ID.
    ///
    /// * `launched-availability-zone` - The Availability Zone in which the
    /// request is launched.
    ///
    /// * `launched-availability-zone-id` - The ID of the Availability Zone
    /// in which the request is launched.
    ///
    /// * `network-interface.addresses.primary` - Indicates whether the IP
    /// address is the primary private IP address.
    ///
    /// * `network-interface.delete-on-termination` - Indicates whether the
    /// network interface is deleted when the instance is terminated.
    ///
    /// * `network-interface.description` - A description of the network
    /// interface.
    ///
    /// * `network-interface.device-index` - The index of the device for the
    /// network interface attachment on the instance.
    ///
    /// * `network-interface.group-id` - The ID of the security group
    /// associated with the network interface.
    ///
    /// * `network-interface.network-interface-id` - The ID of the network
    /// interface.
    ///
    /// * `network-interface.private-ip-address` - The primary private IP
    /// address of the network interface.
    ///
    /// * `network-interface.subnet-id` - The ID of the subnet for the
    /// instance.
    ///
    /// * `product-description` - The product description associated with the
    /// instance (`Linux/UNIX` | `Windows`).
    ///
    /// * `spot-instance-request-id` - The Spot Instance request ID.
    ///
    /// * `spot-price` - The maximum hourly price for any Spot Instance
    /// launched to fulfill the request.
    ///
    /// * `state` - The state of the Spot Instance request (`open`
    /// | `active` | `closed` | `cancelled` |
    /// `failed`). Spot request status information can help you track
    /// your Amazon EC2 Spot Instance requests. For more information, see [Spot
    /// request
    /// status](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-request-status.html) in the *Amazon EC2 User Guide*.
    ///
    /// * `status-code` - The short code describing the most recent
    /// evaluation of your Spot Instance request.
    ///
    /// * `status-message` - The message explaining the status of the Spot
    /// Instance request.
    ///
    /// * `tag:` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `type` - The type of Spot Instance request (`one-time` |
    /// `persistent`).
    ///
    /// * `valid-from` - The start date of the request.
    ///
    /// * `valid-until` - The end date of the request.
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

    /// The IDs of the Spot Instance requests.
    spot_instance_request_ids: ?[]const []const u8 = null,
};

pub const DescribeSpotInstanceRequestsOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    /// The Spot Instance requests.
    spot_instance_requests: ?[]const SpotInstanceRequest = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSpotInstanceRequestsInput, options: Options) !DescribeSpotInstanceRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSpotInstanceRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeSpotInstanceRequests&Version=2016-11-15");
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
    if (input.spot_instance_request_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotInstanceRequestId.SpotInstanceRequestId.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSpotInstanceRequestsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSpotInstanceRequestsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "spotInstanceRequestSet")) {
                    result.spot_instance_requests = try serde.deserializeSpotInstanceRequestList(allocator, &reader, "item");
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
