const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FleetExcessCapacityTerminationPolicy = @import("fleet_excess_capacity_termination_policy.zig").FleetExcessCapacityTerminationPolicy;
const FleetLaunchTemplateConfigRequest = @import("fleet_launch_template_config_request.zig").FleetLaunchTemplateConfigRequest;
const OnDemandOptionsRequest = @import("on_demand_options_request.zig").OnDemandOptionsRequest;
const SpotOptionsRequest = @import("spot_options_request.zig").SpotOptionsRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TargetCapacitySpecificationRequest = @import("target_capacity_specification_request.zig").TargetCapacitySpecificationRequest;
const FleetType = @import("fleet_type.zig").FleetType;
const CreateFleetError = @import("create_fleet_error.zig").CreateFleetError;
const CreateFleetInstance = @import("create_fleet_instance.zig").CreateFleetInstance;
const serde = @import("serde.zig");

/// Creates an EC2 Fleet that contains the configuration information for
/// On-Demand Instances and Spot Instances.
/// Instances are launched immediately if there is available capacity.
///
/// A single EC2 Fleet can include multiple launch specifications that vary by
/// instance type,
/// AMI, Availability Zone, or subnet.
///
/// For more information, see [EC2
/// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet.html)
/// in the *Amazon EC2 User Guide*.
pub const CreateFleetInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. If you do not specify a client token, a randomly generated token is
    /// used for
    /// the request to ensure idempotency.
    ///
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// Reserved.
    context: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether running instances should be terminated if the total target
    /// capacity of
    /// the EC2 Fleet is decreased below the current size of the EC2 Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?FleetExcessCapacityTerminationPolicy = null,

    /// The configuration for the EC2 Fleet.
    launch_template_configs: []const FleetLaunchTemplateConfigRequest,

    /// Describes the configuration of On-Demand Instances in an EC2 Fleet.
    on_demand_options: ?OnDemandOptionsRequest = null,

    /// Indicates whether EC2 Fleet should replace unhealthy Spot Instances.
    /// Supported only for
    /// fleets of type `maintain`. For more information, see [EC2 Fleet
    /// health
    /// checks](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-ec2-fleet.html#ec2-fleet-health-checks) in the *Amazon EC2 User Guide*.
    replace_unhealthy_instances: ?bool = null,

    /// Describes the configuration of Spot Instances in an EC2 Fleet.
    spot_options: ?SpotOptionsRequest = null,

    /// The key-value pair for tagging the EC2 Fleet request on creation. For more
    /// information, see
    /// [Tag your
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-resources).
    ///
    /// If the fleet type is `instant`, specify a resource type of `fleet`
    /// to tag the fleet or `instance` to tag the instances at launch.
    ///
    /// If the fleet type is `maintain` or `request`, specify a resource
    /// type of `fleet` to tag the fleet. You cannot specify a resource type of
    /// `instance`. To tag instances at launch, specify the tags in a [launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html#create-launch-template).
    tag_specifications: ?[]const TagSpecification = null,

    /// The number of units to request.
    target_capacity_specification: TargetCapacitySpecificationRequest,

    /// Indicates whether running instances should be terminated when the EC2 Fleet
    /// expires.
    terminate_instances_with_expiration: ?bool = null,

    /// The fleet type. The default value is `maintain`.
    ///
    /// * `maintain` - The EC2 Fleet places an asynchronous request for your desired
    /// capacity, and continues to maintain your desired Spot capacity by
    /// replenishing
    /// interrupted Spot Instances.
    ///
    /// * `request` - The EC2 Fleet places an asynchronous one-time request for your
    /// desired capacity, but does submit Spot requests in alternative capacity
    /// pools if Spot
    /// capacity is unavailable, and does not maintain Spot capacity if Spot
    /// Instances are
    /// interrupted.
    ///
    /// * `instant` - The EC2 Fleet places a synchronous one-time request for your
    /// desired capacity, and returns errors for any instances that could not be
    /// launched.
    ///
    /// For more information, see [EC2 Fleet
    /// request
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-request-type.html) in the *Amazon EC2 User Guide*.
    @"type": ?FleetType = null,

    /// The start date and time of the request, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// The default is to start fulfilling the request immediately.
    valid_from: ?i64 = null,

    /// The end date and time of the request, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    /// At this point, no new EC2 Fleet requests are placed or able to fulfill the
    /// request. If no value is specified, the request remains until you cancel it.
    valid_until: ?i64 = null,
};

pub const CreateFleetOutput = struct {
    /// Information about the instances that could not be launched by the fleet.
    /// Supported only for
    /// fleets of type `instant`.
    errors: ?[]const CreateFleetError = null,

    /// The ID of the EC2 Fleet.
    fleet_id: ?[]const u8 = null,

    /// Information about the instances that were launched by the fleet. Supported
    /// only for
    /// fleets of type `instant`.
    instances: ?[]const CreateFleetInstance = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateFleetInput, options: Options) !CreateFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateFleet&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.context) |v| {
        try body_buf.appendSlice(alloc, "&Context=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.excess_capacity_termination_policy) |v| {
        try body_buf.appendSlice(alloc, "&ExcessCapacityTerminationPolicy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.on_demand_options) |v| {
        if (v.allocation_strategy) |sv| {
            try body_buf.appendSlice(alloc, "&OnDemandOptions.AllocationStrategy=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.max_total_price) |sv| {
            try body_buf.appendSlice(alloc, "&OnDemandOptions.MaxTotalPrice=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.min_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&OnDemandOptions.MinTargetCapacity=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.single_availability_zone) |sv| {
            try body_buf.appendSlice(alloc, "&OnDemandOptions.SingleAvailabilityZone=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.single_instance_type) |sv| {
            try body_buf.appendSlice(alloc, "&OnDemandOptions.SingleInstanceType=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.replace_unhealthy_instances) |v| {
        try body_buf.appendSlice(alloc, "&ReplaceUnhealthyInstances=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.spot_options) |v| {
        if (v.allocation_strategy) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.AllocationStrategy=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.instance_interruption_behavior) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.InstanceInterruptionBehavior=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.instance_pools_to_use_count) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.InstancePoolsToUseCount=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.max_total_price) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.MaxTotalPrice=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.min_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.MinTargetCapacity=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.single_availability_zone) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.SingleAvailabilityZone=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.single_instance_type) |sv| {
            try body_buf.appendSlice(alloc, "&SpotOptions.SingleInstanceType=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
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
    if (input.target_capacity_specification.default_target_capacity_type) |sv| {
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.DefaultTargetCapacityType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.target_capacity_specification.on_demand_target_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.OnDemandTargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.target_capacity_specification.spot_target_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.SpotTargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.target_capacity_specification.target_capacity_unit_type) |sv| {
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TargetCapacityUnitType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TotalTargetCapacity=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.target_capacity_specification.total_target_capacity}) catch "");
    if (input.terminate_instances_with_expiration) |v| {
        try body_buf.appendSlice(alloc, "&TerminateInstancesWithExpiration=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFleetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "errorSet")) {
                    result.errors = try serde.deserializeCreateFleetErrorsSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "fleetId")) {
                    result.fleet_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "fleetInstanceSet")) {
                    result.instances = try serde.deserializeCreateFleetInstancesSet(&reader, alloc, "item");
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
