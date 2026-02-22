const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyCapacityReservationOutput) void {
        self._arena.deinit();
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyCapacityReservation&Version=2016-11-15");
    if (input.accept) |v| {
        try body_buf.appendSlice(alloc, "&Accept=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.additional_info) |v| {
        try body_buf.appendSlice(alloc, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(alloc, "&EndDate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.end_date_type) |v| {
        try body_buf.appendSlice(alloc, "&EndDateType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(alloc, "&InstanceCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMatchCriteria=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
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
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyCapacityReservationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
