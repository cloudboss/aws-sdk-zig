const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoPlacement = @import("auto_placement.zig").AutoPlacement;
const HostMaintenance = @import("host_maintenance.zig").HostMaintenance;
const HostRecovery = @import("host_recovery.zig").HostRecovery;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const serde = @import("serde.zig");

pub const AllocateHostsInput = struct {
    /// The IDs of the Outpost hardware assets on which to allocate the Dedicated
    /// Hosts. Targeting
    /// specific hardware assets on an Outpost can help to minimize latency between
    /// your workloads.
    /// This parameter is supported only if you specify **OutpostArn**.
    /// If you are allocating the Dedicated Hosts in a Region, omit this parameter.
    ///
    /// * If you specify this parameter, you can omit **Quantity**.
    /// In this case, Amazon EC2 allocates a Dedicated Host on each specified
    /// hardware
    /// asset.
    ///
    /// * If you specify both **AssetIds** and
    /// **Quantity**, then the value for
    /// **Quantity** must be equal to the number of asset IDs
    /// specified.
    asset_ids: ?[]const []const u8 = null,

    /// Indicates whether the host accepts any untargeted instance launches that
    /// match its
    /// instance type configuration, or if it only accepts Host tenancy instance
    /// launches that
    /// specify its unique host ID. For more information, see [ Understanding
    /// auto-placement and
    /// affinity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-dedicated-hosts-work.html#dedicated-hosts-understanding) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Default: `off`
    auto_placement: ?AutoPlacement = null,

    /// The Availability Zone in which to allocate the Dedicated Host.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// Indicates whether to enable or disable host maintenance for the Dedicated
    /// Host. For
    /// more information, see [Host
    /// maintenance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-maintenance.html) in the *Amazon EC2 User Guide*.
    host_maintenance: ?HostMaintenance = null,

    /// Indicates whether to enable or disable host recovery for the Dedicated Host.
    /// Host
    /// recovery is disabled by default. For more information, see [ Host
    /// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-recovery.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// Default: `off`
    host_recovery: ?HostRecovery = null,

    /// Specifies the instance family to be supported by the Dedicated Hosts. If you
    /// specify
    /// an instance family, the Dedicated Hosts support multiple instance types
    /// within that
    /// instance family.
    ///
    /// If you want the Dedicated Hosts to support a specific instance type only,
    /// omit this
    /// parameter and specify **InstanceType** instead. You cannot
    /// specify **InstanceFamily** and **InstanceType** in the same request.
    instance_family: ?[]const u8 = null,

    /// Specifies the instance type to be supported by the Dedicated Hosts. If you
    /// specify an
    /// instance type, the Dedicated Hosts support instances of the specified
    /// instance type
    /// only.
    ///
    /// If you want the Dedicated Hosts to support multiple instance types in a
    /// specific
    /// instance family, omit this parameter and specify **InstanceFamily** instead.
    /// You cannot specify **InstanceType** and **InstanceFamily** in the
    /// same request.
    instance_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Outpost on which
    /// to allocate
    /// the Dedicated Host. If you specify **OutpostArn**, you can
    /// optionally specify **AssetIds**.
    ///
    /// If you are allocating the Dedicated Host in a Region, omit this parameter.
    outpost_arn: ?[]const u8 = null,

    /// The number of Dedicated Hosts to allocate to your account with these
    /// parameters. If you are
    /// allocating the Dedicated Hosts on an Outpost, and you specify **AssetIds**,
    /// you can omit this parameter. In this case, Amazon EC2 allocates a Dedicated
    /// Host on each
    /// specified hardware asset. If you specify both **AssetIds** and
    /// **Quantity**, then the value that you specify for
    /// **Quantity** must be equal to the number of asset IDs specified.
    quantity: ?i32 = null,

    /// The tags to apply to the Dedicated Host during creation.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const AllocateHostsOutput = struct {
    /// The ID of the allocated Dedicated Host. This is used to launch an instance
    /// onto a
    /// specific host.
    host_ids: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AllocateHostsInput, options: CallOptions) !AllocateHostsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AllocateHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AllocateHosts&Version=2016-11-15");
    if (input.asset_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssetId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.auto_placement) |v| {
        try body_buf.appendSlice(allocator, "&AutoPlacement=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.host_maintenance) |v| {
        try body_buf.appendSlice(allocator, "&HostMaintenance=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.host_recovery) |v| {
        try body_buf.appendSlice(allocator, "&HostRecovery=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.instance_family) |v| {
        try body_buf.appendSlice(allocator, "&InstanceFamily=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(allocator, "&InstanceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(allocator, "&OutpostArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.quantity) |v| {
        try body_buf.appendSlice(allocator, "&Quantity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AllocateHostsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AllocateHostsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "hostIdSet")) {
                    result.host_ids = try serde.deserializeResponseHostIdList(allocator, &reader, "item");
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
