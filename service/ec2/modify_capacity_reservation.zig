const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;

/// Modifies a Capacity Reservation's capacity, instance eligibility, and the
/// conditions
/// under which it is to be released. You can't modify a Capacity Reservation's
/// instance
/// type, EBS optimization, platform, instance store settings, Availability
/// Zone, or
/// tenancy. If you need to modify any of these attributes, we recommend that
/// you cancel the
/// Capacity Reservation, and then create a new one with the required
/// attributes. For more
/// information, see [ Modify an active
/// Capacity
/// Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/capacity-reservations-modify.html).
///
/// The allowed modifications depend on the state of the Capacity Reservation:
///
/// * `assessing` or `scheduled` state - You can modify the
/// tags only.
///
/// * `pending` state - You can't modify the Capacity Reservation in any
/// way.
///
/// * `active` state but still within the commitment duration - You can't
/// decrease the instance count or set an end date that is within the commitment
/// duration. All other modifications are allowed.
///
/// * `active` state with no commitment duration or elapsed commitment
/// duration - All modifications are allowed.
///
/// * `expired`, `cancelled`, `unsupported`, or
/// `failed` state - You can't modify the Capacity Reservation in any
/// way.
pub const ModifyCapacityReservationInput = struct {
    /// Reserved. Capacity Reservations you have created are accepted by default.
    accept: ?bool = null,

    /// Reserved for future use.
    additional_info: ?[]const u8 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time at which the Capacity Reservation expires. When a Capacity
    /// Reservation expires, the reserved capacity is released and you can no longer
    /// launch
    /// instances into it. The Capacity Reservation's state changes to `expired`
    /// when
    /// it reaches its end date and time.
    ///
    /// The Capacity Reservation is cancelled within an hour from the specified
    /// time. For
    /// example, if you specify 5/31/2019, 13:30:55, the Capacity Reservation is
    /// guaranteed to
    /// end between 13:30:55 and 14:30:55 on 5/31/2019.
    ///
    /// You must provide an `EndDate` value if `EndDateType` is
    /// `limited`. Omit `EndDate` if `EndDateType` is
    /// `unlimited`.
    end_date: ?i64 = null,

    /// Indicates the way in which the Capacity Reservation ends. A Capacity
    /// Reservation can
    /// have one of the following end types:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until you
    /// explicitly cancel it. Do not provide an `EndDate` value if
    /// `EndDateType` is `unlimited`.
    ///
    /// * `limited` - The Capacity Reservation expires automatically at a
    /// specified date and time. You must provide an `EndDate` value if
    /// `EndDateType` is `limited`.
    end_date_type: ?EndDateType = null,

    /// The number of instances for which to reserve capacity. The number of
    /// instances can't
    /// be increased or decreased by more than `1000` in a single request.
    instance_count: ?i32 = null,

    /// The matching criteria (instance eligibility) that you want to use in the
    /// modified
    /// Capacity Reservation. If you change the instance eligibility of an existing
    /// Capacity
    /// Reservation from `targeted` to `open`, any running instances that
    /// match the attributes of the Capacity Reservation, have the
    /// `CapacityReservationPreference` set to `open`, and are not yet
    /// running in the Capacity Reservation, will automatically use the modified
    /// Capacity
    /// Reservation.
    ///
    /// To modify the instance eligibility, the Capacity Reservation must be
    /// completely idle
    /// (zero usage).
    instance_match_criteria: ?InstanceMatchCriteria = null,
};

pub const ModifyCapacityReservationOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyCapacityReservationOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyCapacityReservationInput, options: Options) !ModifyCapacityReservationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyCapacityReservation&Version=2016-11-15");
    if (input.accept) |v| {
        try body_buf.appendSlice(alloc, "&Accept=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.additional_info) |v| {
        try body_buf.appendSlice(alloc, "&AdditionalInfo=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&CapacityReservationId=");
    try appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
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
    if (input.instance_count) |v| {
        try body_buf.appendSlice(alloc, "&InstanceCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMatchCriteria=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyCapacityReservationOutput {
    _ = status;
    _ = headers;
    var result: ModifyCapacityReservationOutput = .{ .allocator = alloc };
    if (findElement(body, "return")) |content| {
        result.@"return" = std.mem.eql(u8, content, "true");
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
