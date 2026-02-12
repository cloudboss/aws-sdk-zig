const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityReservationDeliveryPreference = @import("capacity_reservation_delivery_preference.zig").CapacityReservationDeliveryPreference;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;
const CapacityReservationInstancePlatform = @import("capacity_reservation_instance_platform.zig").CapacityReservationInstancePlatform;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const CapacityReservationTenancy = @import("capacity_reservation_tenancy.zig").CapacityReservationTenancy;
const CapacityReservation = @import("capacity_reservation.zig").CapacityReservation;
const serde = @import("serde.zig");

/// Creates a new Capacity Reservation with the specified attributes. Capacity
/// Reservations enable you to reserve capacity for your Amazon EC2 instances in
/// a specific
/// Availability Zone for any duration.
///
/// You can create a Capacity Reservation at any time, and you can choose when
/// it starts.
/// You can create a Capacity Reservation for immediate use or you can request a
/// Capacity
/// Reservation for a future date.
///
/// For more information, see [ Reserve compute
/// capacity with On-Demand Capacity
/// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-reservations.html) in the
/// *Amazon EC2 User Guide*.
///
/// Your request to create a Capacity Reservation could fail if:
///
/// * Amazon EC2 does not have sufficient capacity. In this case, try again
/// at a later time, try in a different Availability Zone, or request a smaller
/// Capacity Reservation. If your workload is flexible across instance types and
/// sizes, try with different instance attributes.
///
/// * The requested quantity exceeds your On-Demand Instance quota. In this
///   case,
/// increase your On-Demand Instance quota for the requested instance type and
/// try
/// again. For more information, see [
/// Amazon EC2 Service
/// Quotas](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html) in the
/// *Amazon EC2 User Guide*.
pub const CreateCapacityReservationInput = struct {
    /// The Availability Zone in which to create the Capacity Reservation.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone in which to create the Capacity Reservation.
    availability_zone_id: ?[]const u8 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensure
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// **Note:**
    ///
    /// Required for future-dated Capacity Reservations only. To create a Capacity
    /// Reservation for immediate use, omit this parameter.
    ///
    /// Specify a commitment duration, in seconds, for the future-dated Capacity
    /// Reservation.
    ///
    /// The commitment duration is a minimum duration for which you commit to having
    /// the
    /// future-dated Capacity Reservation in the `active` state in your account
    /// after
    /// it has been delivered.
    ///
    /// For more information, see [ Commitment
    /// duration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cr-concepts.html#cr-commitment-duration).
    commitment_duration: ?i64 = null,

    /// **Note:**
    ///
    /// Required for future-dated Capacity Reservations only. To create a Capacity
    /// Reservation for immediate use, omit this parameter.
    ///
    /// Indicates that the requested capacity will be delivered in addition to any
    /// running
    /// instances or reserved capacity that you have in your account at the
    /// requested date and
    /// time.
    ///
    /// The only supported value is `incremental`.
    delivery_preference: ?CapacityReservationDeliveryPreference = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether the Capacity Reservation supports EBS-optimized instances.
    /// This
    /// optimization provides dedicated throughput to Amazon EBS and an optimized
    /// configuration
    /// stack to provide optimal I/O performance. This optimization isn't available
    /// with all
    /// instance types. Additional usage charges apply when using an EBS- optimized
    /// instance.
    ebs_optimized: ?bool = null,

    /// The date and time at which the Capacity Reservation expires. When a Capacity
    /// Reservation expires, the reserved capacity is released and you can no longer
    /// launch
    /// instances into it. The Capacity Reservation's state changes to `expired`
    /// when
    /// it reaches its end date and time.
    ///
    /// You must provide an `EndDate` value if `EndDateType` is
    /// `limited`. Omit `EndDate` if `EndDateType` is
    /// `unlimited`.
    ///
    /// If the `EndDateType` is `limited`, the Capacity Reservation is
    /// cancelled within an hour from the specified time. For example, if you
    /// specify 5/31/2019,
    /// 13:30:55, the Capacity Reservation is guaranteed to end between 13:30:55 and
    /// 14:30:55 on
    /// 5/31/2019.
    ///
    /// If you are requesting a future-dated Capacity Reservation, you can't specify
    /// an end
    /// date and time that is within the commitment duration.
    end_date: ?i64 = null,

    /// Indicates the way in which the Capacity Reservation ends. A Capacity
    /// Reservation can
    /// have one of the following end types:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until you
    /// explicitly cancel it. Do not provide an `EndDate` if the
    /// `EndDateType` is `unlimited`.
    ///
    /// * `limited` - The Capacity Reservation expires automatically at a
    /// specified date and time. You must provide an `EndDate` value if the
    /// `EndDateType` value is `limited`.
    end_date_type: ?EndDateType = null,

    /// *Deprecated.*
    ephemeral_storage: ?bool = null,

    /// The number of instances for which to reserve capacity.
    ///
    /// **Note:**
    ///
    /// You can request future-dated Capacity Reservations for an instance count
    /// with a
    /// minimum of 32 vCPUs. For example, if you request a future-dated Capacity
    /// Reservation for `m5.xlarge` instances, you must request at least 8
    /// instances (*8 * m5.xlarge = 32 vCPUs*).
    ///
    /// Valid range: 1 - 1000
    instance_count: i32,

    /// Indicates the type of instance launches that the Capacity Reservation
    /// accepts. The
    /// options include:
    ///
    /// * `open` - The Capacity Reservation automatically matches all instances
    /// that have matching attributes (instance type, platform, and Availability
    /// Zone).
    /// Instances that have matching attributes run in the Capacity Reservation
    /// automatically without specifying any additional parameters.
    ///
    /// * `targeted` - The Capacity Reservation only accepts instances that
    /// have matching attributes (instance type, platform, and Availability Zone),
    /// and
    /// explicitly target the Capacity Reservation. This ensures that only permitted
    /// instances can use the reserved capacity.
    ///
    /// **Note:**
    ///
    /// If you are requesting a future-dated Capacity Reservation, you must specify
    /// `targeted`.
    ///
    /// Default: `open`
    instance_match_criteria: ?InstanceMatchCriteria = null,

    /// The type of operating system for which to reserve capacity.
    instance_platform: CapacityReservationInstancePlatform,

    /// The instance type for which to reserve capacity.
    ///
    /// **Note:**
    ///
    /// You can request future-dated Capacity Reservations for instance types in the
    /// C, M,
    /// R, I, T, and G instance families only.
    ///
    /// For more information, see [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the
    /// *Amazon EC2 User Guide*.
    instance_type: []const u8,

    /// **Note:**
    ///
    /// Not supported for future-dated Capacity Reservations.
    ///
    /// The Amazon Resource Name (ARN) of the Outpost on which to create the
    /// Capacity
    /// Reservation.
    outpost_arn: ?[]const u8 = null,

    /// **Note:**
    ///
    /// Not supported for future-dated Capacity Reservations.
    ///
    /// The Amazon Resource Name (ARN) of the cluster placement group in which to
    /// create the
    /// Capacity Reservation. For more information, see [ Capacity Reservations for
    /// cluster
    /// placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cr-cpg.html) in
    /// the *Amazon EC2 User Guide*.
    placement_group_arn: ?[]const u8 = null,

    /// **Note:**
    ///
    /// Required for future-dated Capacity Reservations only. To create a Capacity
    /// Reservation for immediate use, omit this parameter.
    ///
    /// The date and time at which the future-dated Capacity Reservation should
    /// become
    /// available for use, in the ISO8601 format in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    ///
    /// You can request a future-dated Capacity Reservation between 5 and 120 days
    /// in
    /// advance.
    start_date: ?i64 = null,

    /// The tags to apply to the Capacity Reservation during launch.
    tag_specifications: ?[]const TagSpecification = null,

    /// Indicates the tenancy of the Capacity Reservation. A Capacity Reservation
    /// can have one
    /// of the following tenancy settings:
    ///
    /// * `default` - The Capacity Reservation is created on hardware that is
    /// shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Reservation is created on single-tenant
    /// hardware that is dedicated to a single Amazon Web Services account.
    tenancy: ?CapacityReservationTenancy = null,
};

pub const CreateCapacityReservationOutput = struct {
    /// Information about the Capacity Reservation.
    capacity_reservation: ?CapacityReservation = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateCapacityReservationOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateCapacityReservationInput, options: Options) !CreateCapacityReservationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateCapacityReservation&Version=2016-11-15");
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
    if (input.commitment_duration) |v| {
        try body_buf.appendSlice(alloc, "&CommitmentDuration=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.delivery_preference) |v| {
        try body_buf.appendSlice(alloc, "&DeliveryPreference=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ebs_optimized) |v| {
        try body_buf.appendSlice(alloc, "&EbsOptimized=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(alloc, "&EndDate=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.end_date_type) |v| {
        try body_buf.appendSlice(alloc, "&EndDateType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.ephemeral_storage) |v| {
        try body_buf.appendSlice(alloc, "&EphemeralStorage=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceCount=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.instance_count}) catch "");
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMatchCriteria=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&InstancePlatform=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.instance_platform));
    try body_buf.appendSlice(alloc, "&InstanceType=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_type);
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.placement_group_arn) |v| {
        try body_buf.appendSlice(alloc, "&PlacementGroupArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.start_date) |v| {
        try body_buf.appendSlice(alloc, "&StartDate=");
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
    if (input.tenancy) |v| {
        try body_buf.appendSlice(alloc, "&Tenancy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCapacityReservationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateCapacityReservationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "capacityReservation")) {
                    result.capacity_reservation = try serde.deserializeCapacityReservation(&reader, alloc);
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
