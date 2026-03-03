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
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCapacityReservationFleetInput, options: Options) !CreateCapacityReservationFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCapacityReservationFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateCapacityReservationFleet&Version=2016-11-15");
    if (input.allocation_strategy) |v| {
        try body_buf.appendSlice(allocator, "&AllocationStrategy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(allocator, "&EndDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(allocator, "&InstanceMatchCriteria=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    for (input.instance_type_specifications, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.AvailabilityZone=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.availability_zone) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.AvailabilityZoneId=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.availability_zone_id) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.EbsOptimized=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.ebs_optimized) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.InstancePlatform=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.instance_platform) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.InstanceType=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.instance_type) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.Priority=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.priority) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypeSpecification.member.{d}.Weight=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.weight) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
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
    if (input.tenancy) |v| {
        try body_buf.appendSlice(allocator, "&Tenancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(allocator, "&TotalTargetCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.total_target_capacity}) catch "");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCapacityReservationFleetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateCapacityReservationFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "allocationStrategy")) {
                    result.allocation_strategy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "capacityReservationFleetId")) {
                    result.capacity_reservation_fleet_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "createTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "endDate")) {
                    result.end_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "fleetCapacityReservationSet")) {
                    result.fleet_capacity_reservations = try serde.deserializeFleetCapacityReservationSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "instanceMatchCriteria")) {
                    result.instance_match_criteria = std.meta.stringToEnum(FleetInstanceMatchCriteria, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "state")) {
                    result.state = std.meta.stringToEnum(CapacityReservationFleetState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "tenancy")) {
                    result.tenancy = std.meta.stringToEnum(FleetCapacityReservationTenancy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "totalFulfilledCapacity")) {
                    result.total_fulfilled_capacity = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "totalTargetCapacity")) {
                    result.total_target_capacity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
