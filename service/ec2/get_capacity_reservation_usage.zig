const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceUsage = @import("instance_usage.zig").InstanceUsage;
const InterruptibleCapacityAllocation = @import("interruptible_capacity_allocation.zig").InterruptibleCapacityAllocation;
const InterruptionInfo = @import("interruption_info.zig").InterruptionInfo;
const CapacityReservationState = @import("capacity_reservation_state.zig").CapacityReservationState;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCapacityReservationUsageInput, options: CallOptions) !GetCapacityReservationUsageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCapacityReservationUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetCapacityReservationUsage&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCapacityReservationUsageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetCapacityReservationUsageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "availableInstanceCount")) {
                    result.available_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "capacityReservationId")) {
                    result.capacity_reservation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceType")) {
                    result.instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceUsageSet")) {
                    result.instance_usages = try serde.deserializeInstanceUsageSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "interruptible")) {
                    result.interruptible = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "interruptibleCapacityAllocation")) {
                    result.interruptible_capacity_allocation = try serde.deserializeInterruptibleCapacityAllocation(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "interruptionInfo")) {
                    result.interruption_info = try serde.deserializeInterruptionInfo(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "state")) {
                    result.state = std.meta.stringToEnum(CapacityReservationState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "totalInstanceCount")) {
                    result.total_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
