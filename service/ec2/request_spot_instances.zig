const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const RequestSpotLaunchSpecification = @import("request_spot_launch_specification.zig").RequestSpotLaunchSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;
const SpotInstanceRequest = @import("spot_instance_request.zig").SpotInstanceRequest;

/// Creates a Spot Instance request.
///
/// For more information, see [Work with Spot
/// Instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html) in
/// the *Amazon EC2 User Guide*.
///
/// **Important:**
///
/// We strongly discourage using the RequestSpotInstances API because it is a
/// legacy
/// API with no planned investment. For options for requesting Spot Instances,
/// see
/// [Which
/// is the best Spot request method to
/// use?](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-best-practices.html#which-spot-request-method-to-use) in the
/// *Amazon EC2 User Guide*.
pub const RequestSpotInstancesInput = struct {
    /// The user-specified name for a logical grouping of requests.
    ///
    /// When you specify an Availability Zone group in a Spot Instance request, all
    /// Spot
    /// Instances in the request are launched in the same Availability Zone.
    /// Instance proximity
    /// is maintained with this parameter, but the choice of Availability Zone is
    /// not. The group
    /// applies only to requests for Spot Instances of the same instance type. Any
    /// additional
    /// Spot Instance requests that are specified with the same Availability Zone
    /// group name are
    /// launched in that same Availability Zone, as long as at least one instance
    /// from the group
    /// is still active.
    ///
    /// If there is no active instance running in the Availability Zone group that
    /// you specify
    /// for a new Spot Instance request (all instances are terminated, the request
    /// is expired,
    /// or the maximum price you specified falls below current Spot price), then
    /// Amazon EC2 launches
    /// the instance in any Availability Zone where the constraint can be met.
    /// Consequently, the
    /// subsequent set of Spot Instances could be placed in a different zone from
    /// the original
    /// request, even if you specified the same Availability Zone group.
    ///
    /// Default: Instances are launched in any available Availability Zone.
    availability_zone_group: ?[]const u8 = null,

    /// Deprecated.
    block_duration_minutes: ?i32 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [Ensuring idempotency in
    /// Amazon EC2 API
    /// requests](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html) in the *Amazon EC2 User Guide*.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The maximum number of Spot Instances to launch.
    ///
    /// Default: 1
    instance_count: ?i32 = null,

    /// The behavior when a Spot Instance is interrupted. The default is
    /// `terminate`.
    instance_interruption_behavior: ?InstanceInterruptionBehavior = null,

    /// The instance launch group. Launch groups are Spot Instances that launch
    /// together and
    /// terminate together.
    ///
    /// Default: Instances are launched and terminated individually
    launch_group: ?[]const u8 = null,

    /// The launch specification.
    launch_specification: ?RequestSpotLaunchSpecification = null,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend
    /// using this parameter because it can lead to increased interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// **Important:**
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8 = null,

    /// The key-value pair for tagging the Spot Instance request on creation. The
    /// value for
    /// `ResourceType` must be `spot-instances-request`, otherwise the
    /// Spot Instance request fails. To tag the Spot Instance request after it has
    /// been created,
    /// see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,

    /// The Spot Instance request type.
    ///
    /// Default: `one-time`
    @"type": ?SpotInstanceType = null,

    /// The start date of the request. If this is a one-time request, the request
    /// becomes
    /// active at this date and time and remains active until all instances launch,
    /// the request
    /// expires, or the request is canceled. If the request is persistent, the
    /// request becomes
    /// active at this date and time and remains active until it expires or is
    /// canceled.
    ///
    /// The specified start date and time cannot be equal to the current date and
    /// time. You
    /// must specify a start date and time that occurs after the current date and
    /// time.
    valid_from: ?i64 = null,

    /// The end date of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    ///
    /// * For a persistent request, the request remains active until the
    /// `ValidUntil` date and time is reached. Otherwise, the request
    /// remains active until you cancel it.
    ///
    /// * For a one-time request, the request remains active until all instances
    ///   launch,
    /// the request is canceled, or the `ValidUntil` date and time is
    /// reached. By default, the request is valid for 7 days from the date the
    /// request
    /// was created.
    valid_until: ?i64 = null,
};

pub const RequestSpotInstancesOutput = struct {
    /// The Spot Instance requests.
    spot_instance_requests: ?[]const SpotInstanceRequest = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const RequestSpotInstancesOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RequestSpotInstancesInput, options: Options) !RequestSpotInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RequestSpotInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RequestSpotInstances&Version=2016-11-15");
    if (input.availability_zone_group) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneGroup=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.block_duration_minutes) |v| {
        try body_buf.appendSlice(alloc, "&BlockDurationMinutes=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(alloc, "&InstanceCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.instance_interruption_behavior) |v| {
        try body_buf.appendSlice(alloc, "&InstanceInterruptionBehavior=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.launch_group) |v| {
        try body_buf.appendSlice(alloc, "&LaunchGroup=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_specification) |v| {
        if (v.addressing_type) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.AddressingType=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.ebs_optimized) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.EbsOptimized=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.image_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.ImageId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.instance_type) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.InstanceType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.kernel_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.KernelId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.key_name) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.KeyName=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.ramdisk_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.RamdiskId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.subnet_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.SubnetId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_data) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.UserData=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.spot_price) |v| {
        try body_buf.appendSlice(alloc, "&SpotPrice=");
        try appendUrlEncoded(alloc, &body_buf, v);
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
    if (input.@"type") |v| {
        try body_buf.appendSlice(alloc, "&Type=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.valid_from) |v| {
        try body_buf.appendSlice(alloc, "&ValidFrom=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.valid_until) |v| {
        try body_buf.appendSlice(alloc, "&ValidUntil=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestSpotInstancesOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: RequestSpotInstancesOutput = .{ .allocator = alloc };

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
