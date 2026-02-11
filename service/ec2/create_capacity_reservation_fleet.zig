const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FleetInstanceMatchCriteria = @import("fleet_instance_match_criteria.zig").FleetInstanceMatchCriteria;
const ReservationFleetInstanceSpecification = @import("reservation_fleet_instance_specification.zig").ReservationFleetInstanceSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const FleetCapacityReservationTenancy = @import("fleet_capacity_reservation_tenancy.zig").FleetCapacityReservationTenancy;
const FleetCapacityReservation = @import("fleet_capacity_reservation.zig").FleetCapacityReservation;
const CapacityReservationFleetState = @import("capacity_reservation_fleet_state.zig").CapacityReservationFleetState;
const Tag = @import("tag.zig").Tag;

/// Creates a Capacity Reservation Fleet. For more information, see [Create a
/// Capacity Reservation
/// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-cr-fleets.html#create-crfleet) in the
/// *Amazon EC2 User Guide*.
pub const CreateCapacityReservationFleetInput = struct {
    /// The strategy used by the Capacity Reservation Fleet to determine which of
    /// the
    /// specified instance types to use. Currently, only the `prioritized`
    /// allocation
    /// strategy is supported. For more information, see [ Allocation
    /// strategy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#allocation-strategy) in the *Amazon EC2 User Guide*.
    ///
    /// Valid values: `prioritized`
    allocation_strategy: ?[]const u8 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensure
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time at which the Capacity Reservation Fleet expires. When the
    /// Capacity
    /// Reservation Fleet expires, its state changes to `expired` and all of the
    /// Capacity Reservations in the Fleet expire.
    ///
    /// The Capacity Reservation Fleet expires within an hour after the specified
    /// time. For
    /// example, if you specify `5/31/2019`, `13:30:55`, the Capacity
    /// Reservation Fleet is guaranteed to expire between `13:30:55` and
    /// `14:30:55` on `5/31/2019`.
    end_date: ?i64 = null,

    /// Indicates the type of instance launches that the Capacity Reservation Fleet
    /// accepts.
    /// All Capacity Reservations in the Fleet inherit this instance matching
    /// criteria.
    ///
    /// Currently, Capacity Reservation Fleets support `open` instance matching
    /// criteria only. This means that instances that have matching attributes
    /// (instance type,
    /// platform, and Availability Zone) run in the Capacity Reservations
    /// automatically.
    /// Instances do not need to explicitly target a Capacity Reservation Fleet to
    /// use its
    /// reserved capacity.
    instance_match_criteria: ?FleetInstanceMatchCriteria = null,

    /// Information about the instance types for which to reserve the capacity.
    instance_type_specifications: []const ReservationFleetInstanceSpecification,

    /// The tags to assign to the Capacity Reservation Fleet. The tags are
    /// automatically
    /// assigned to the Capacity Reservations in the Fleet.
    tag_specifications: ?[]const TagSpecification = null,

    /// Indicates the tenancy of the Capacity Reservation Fleet. All Capacity
    /// Reservations in
    /// the Fleet inherit this tenancy. The Capacity Reservation Fleet can have one
    /// of the
    /// following tenancy settings:
    ///
    /// * `default` - The Capacity Reservation Fleet is created on hardware
    /// that is shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Reservations are created on single-tenant
    /// hardware that is dedicated to a single Amazon Web Services account.
    tenancy: ?FleetCapacityReservationTenancy = null,

    /// The total number of capacity units to be reserved by the Capacity
    /// Reservation Fleet.
    /// This value, together with the instance type weights that you assign to each
    /// instance
    /// type used by the Fleet determine the number of instances for which the Fleet
    /// reserves
    /// capacity. Both values are based on units that make sense for your workload.
    /// For more
    /// information, see [Total target
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#target-capacity) in the *Amazon EC2 User Guide*.
    total_target_capacity: i32,
};

pub const CreateCapacityReservationFleetOutput = struct {
    /// The allocation strategy used by the Capacity Reservation Fleet.
    allocation_strategy: ?[]const u8 = null,

    /// The ID of the Capacity Reservation Fleet.
    capacity_reservation_fleet_id: ?[]const u8 = null,

    /// The date and time at which the Capacity Reservation Fleet was created.
    create_time: ?i64 = null,

    /// The date and time at which the Capacity Reservation Fleet expires.
    end_date: ?i64 = null,

    /// Information about the individual Capacity Reservations in the Capacity
    /// Reservation
    /// Fleet.
    fleet_capacity_reservations: ?[]const FleetCapacityReservation = null,

    /// The instance matching criteria for the Capacity Reservation Fleet.
    instance_match_criteria: ?FleetInstanceMatchCriteria = null,

    /// The status of the Capacity Reservation Fleet.
    state: ?CapacityReservationFleetState = null,

    /// The tags assigned to the Capacity Reservation Fleet.
    tags: ?[]const Tag = null,

    /// Indicates the tenancy of Capacity Reservation Fleet.
    tenancy: ?FleetCapacityReservationTenancy = null,

    /// The requested capacity units that have been successfully reserved.
    total_fulfilled_capacity: ?f64 = null,

    /// The total number of capacity units for which the Capacity Reservation Fleet
    /// reserves
    /// capacity.
    total_target_capacity: ?i32 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateCapacityReservationFleetOutput) void {
        if (self.allocation_strategy) |v| {
            self.allocator.free(v);
        }
        if (self.capacity_reservation_fleet_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateCapacityReservationFleetInput, options: Options) !CreateCapacityReservationFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCapacityReservationFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateCapacityReservationFleet&Version=2016-11-15");
    if (input.allocation_strategy) |v| {
        try body_buf.appendSlice(alloc, "&AllocationStrategy=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(alloc, "&EndDate=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMatchCriteria=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    for (input.instance_type_specifications, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.AvailabilityZone=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.availability_zone) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.AvailabilityZoneId=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.availability_zone_id) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.EbsOptimized=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.ebs_optimized) |v| {
                try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.InstancePlatform=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.instance_platform) |v| {
                try appendUrlEncoded(alloc, &body_buf, @tagName(v));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.InstanceType=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.instance_type) |v| {
                try appendUrlEncoded(alloc, &body_buf, @tagName(v));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.Priority=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.priority) |v| {
                try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecifications.member.{d}.Weight=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.weight) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
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
    if (input.tenancy) |v| {
        try body_buf.appendSlice(alloc, "&Tenancy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&TotalTargetCapacity=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.total_target_capacity}) catch "");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCapacityReservationFleetOutput {
    _ = status;
    _ = headers;
    var result: CreateCapacityReservationFleetOutput = .{ .allocator = alloc };
    if (findElement(body, "allocationStrategy")) |content| {
        result.allocation_strategy = try alloc.dupe(u8, content);
    }
    if (findElement(body, "capacityReservationFleetId")) |content| {
        result.capacity_reservation_fleet_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "createTime")) |content| {
        result.create_time = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findElement(body, "endDate")) |content| {
        result.end_date = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findElement(body, "totalTargetCapacity")) |content| {
        result.total_target_capacity = std.fmt.parseInt(i32, content, 10) catch null;
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
