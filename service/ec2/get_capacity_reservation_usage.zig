const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceUsage = @import("instance_usage.zig").InstanceUsage;
const InterruptibleCapacityAllocation = @import("interruptible_capacity_allocation.zig").InterruptibleCapacityAllocation;
const InterruptionInfo = @import("interruption_info.zig").InterruptionInfo;
const CapacityReservationState = @import("capacity_reservation_state.zig").CapacityReservationState;

/// Gets usage information about a Capacity Reservation. If the Capacity
/// Reservation is
/// shared, it shows usage information for the Capacity Reservation owner and
/// each Amazon Web Services account that is currently using the shared
/// capacity. If the Capacity
/// Reservation is not shared, it shows only the Capacity Reservation owner's
/// usage.
pub const GetCapacityReservationUsageInput = struct {
    /// The ID of the Capacity Reservation.
    capacity_reservation_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items, make another request with the token returned in the output. For
    /// more information,
    /// see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,
};

pub const GetCapacityReservationUsageOutput = struct {
    /// The remaining capacity. Indicates the number of instances that can be
    /// launched in the
    /// Capacity Reservation.
    available_instance_count: ?i32 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8 = null,

    /// The type of instance for which the Capacity Reservation reserves capacity.
    instance_type: ?[]const u8 = null,

    /// Information about the Capacity Reservation usage.
    instance_usages: ?[]const InstanceUsage = null,

    /// Indicates whether the Capacity Reservation is interruptible, meaning
    /// instances may be terminated when the owner reclaims capacity.
    interruptible: ?bool = null,

    /// Information about the capacity allocated to the interruptible Capacity
    /// Reservation, including instance counts and allocation status.
    interruptible_capacity_allocation: ?InterruptibleCapacityAllocation = null,

    /// Details about the interruption configuration and source reservation for
    /// interruptible Capacity Reservations.
    interruption_info: ?InterruptionInfo = null,

    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The current state of the Capacity Reservation. A Capacity Reservation can be
    /// in one of
    /// the following states:
    ///
    /// * `active` - The capacity is available for use.
    ///
    /// * `expired` - The Capacity Reservation expired automatically at the date and
    ///   time
    /// specified in your reservation request. The reserved capacity is no longer
    /// available for your use.
    ///
    /// * `cancelled` - The Capacity Reservation was canceled. The reserved capacity
    ///   is no
    /// longer available for your use.
    ///
    /// * `pending` - The Capacity Reservation request was successful but the
    ///   capacity
    /// provisioning is still pending.
    ///
    /// * `failed` - The Capacity Reservation request has failed. A request can fail
    ///   due to
    /// request parameters that are not valid, capacity constraints, or instance
    /// limit constraints. You
    /// can view a failed request for 60 minutes.
    ///
    /// * `scheduled` - (*Future-dated Capacity Reservations*) The
    /// future-dated Capacity Reservation request was approved and the Capacity
    /// Reservation is scheduled
    /// for delivery on the requested start date.
    ///
    /// * `payment-pending` - (*Capacity Blocks*) The upfront
    /// payment has not been processed yet.
    ///
    /// * `payment-failed` - (*Capacity Blocks*) The upfront
    /// payment was not processed in the 12-hour time frame. Your Capacity Block was
    /// released.
    ///
    /// * `assessing` - (*Future-dated Capacity Reservations*)
    /// Amazon EC2 is assessing your request for a future-dated Capacity
    /// Reservation.
    ///
    /// * `delayed` - (*Future-dated Capacity Reservations*) Amazon EC2
    /// encountered a delay in provisioning the requested future-dated Capacity
    /// Reservation. Amazon EC2 is
    /// unable to deliver the requested capacity by the requested start date and
    /// time.
    ///
    /// * `unsupported` - (*Future-dated Capacity Reservations*) Amazon EC2
    /// can't support the future-dated Capacity Reservation request due to capacity
    /// constraints. You can view
    /// unsupported requests for 30 days. The Capacity Reservation will not be
    /// delivered.
    state: ?CapacityReservationState = null,

    /// The number of instances for which the Capacity Reservation reserves
    /// capacity.
    total_instance_count: ?i32 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetCapacityReservationUsageOutput) void {
        if (self.capacity_reservation_id) |v| {
            self.allocator.free(v);
        }
        if (self.instance_type) |v| {
            self.allocator.free(v);
        }
        if (self.next_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetCapacityReservationUsageInput, options: Options) !GetCapacityReservationUsageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetCapacityReservationUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetCapacityReservationUsage&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CapacityReservationId=");
    try appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetCapacityReservationUsageOutput {
    _ = status;
    _ = headers;
    var result: GetCapacityReservationUsageOutput = .{ .allocator = alloc };
    if (findElement(body, "availableInstanceCount")) |content| {
        result.available_instance_count = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "capacityReservationId")) |content| {
        result.capacity_reservation_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "instanceType")) |content| {
        result.instance_type = try alloc.dupe(u8, content);
    }
    if (findElement(body, "interruptible")) |content| {
        result.interruptible = std.mem.eql(u8, content, "true");
    }
    if (findElement(body, "nextToken")) |content| {
        result.next_token = try alloc.dupe(u8, content);
    }
    if (findElement(body, "totalInstanceCount")) |content| {
        result.total_instance_count = std.fmt.parseInt(i32, content, 10) catch null;
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
