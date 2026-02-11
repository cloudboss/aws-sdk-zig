const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoPlacement = @import("auto_placement.zig").AutoPlacement;
const HostMaintenance = @import("host_maintenance.zig").HostMaintenance;
const HostRecovery = @import("host_recovery.zig").HostRecovery;
const TagSpecification = @import("tag_specification.zig").TagSpecification;

/// Allocates a Dedicated Host to your account. At a minimum, specify the
/// supported
/// instance type or instance family, the Availability Zone in which to allocate
/// the host,
/// and the number of hosts to allocate.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AllocateHostsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AllocateHostsInput, options: Options) !AllocateHostsOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: AllocateHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AllocateHosts&Version=2016-11-15");
    if (input.asset_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssetIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.auto_placement) |v| {
        try body_buf.appendSlice(alloc, "&AutoPlacement=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.host_maintenance) |v| {
        try body_buf.appendSlice(alloc, "&HostMaintenance=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.host_recovery) |v| {
        try body_buf.appendSlice(alloc, "&HostRecovery=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_family) |v| {
        try body_buf.appendSlice(alloc, "&InstanceFamily=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(alloc, "&InstanceType=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.quantity) |v| {
        try body_buf.appendSlice(alloc, "&Quantity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AllocateHostsOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: AllocateHostsOutput = .{ .allocator = alloc };

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
