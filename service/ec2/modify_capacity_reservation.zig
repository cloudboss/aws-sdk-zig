const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;
const CapacityReservationAdjustmentDetails = @import("capacity_reservation_adjustment_details.zig").CapacityReservationAdjustmentDetails;
const CapacityReservationAdjustmentStatus = @import("capacity_reservation_adjustment_status.zig").CapacityReservationAdjustmentStatus;
const serde = @import("serde.zig");

pub const ModifyCapacityReservationInput = struct {
    /// Reserved. Capacity Reservations you have created are accepted by default.
    accept: ?bool = null,

    /// Indicates that you accept the modification terms of the quote identified by
    /// `QuoteId`. To apply a quoted modification, set this parameter to
    /// `true`.
    accept_modification_terms: ?bool = null,

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

    /// The ID of the quote that describes the modification you want to apply.
    /// Generate a quote
    /// by using `CreateCapacityReservationDateChangeQuote`. The quote must be in
    /// the
    /// `active` state, and each quote can be used only once.
    quote_id: ?[]const u8 = null,

    /// The new start date for the Capacity Reservation, in the ISO8601 format in
    /// the UTC time
    /// zone (`YYYY-MM-DDThh:mm:ss.sssZ`). Applies to future-dated Capacity
    /// Reservations only. Requires a quote from
    /// `CreateCapacityReservationDateChangeQuote`; pass the quote ID in
    /// `QuoteId` with `AcceptModificationTerms` set to
    /// `true`.
    start_date: ?i64 = null,
};

pub const ModifyCapacityReservationOutput = struct {
    /// The configuration that the Capacity Reservation will have after the
    /// adjustment is
    /// applied.
    adjustment_details: ?CapacityReservationAdjustmentDetails = null,

    /// The status of the requested modification. For a description of each possible
    /// value, see
    /// the `adjustmentStatus` field of the `CapacityReservation` data
    /// type.
    adjustment_status: ?CapacityReservationAdjustmentStatus = null,

    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, options: CallOptions) !ModifyCapacityReservationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCapacityReservation&Version=2016-11-15");
    if (input.accept) |v| {
        try body_buf.appendSlice(allocator, "&Accept=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.accept_modification_terms) |v| {
        try body_buf.appendSlice(allocator, "&AcceptModificationTerms=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.additional_info) |v| {
        try body_buf.appendSlice(allocator, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(allocator, "&EndDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.end_date_type) |v| {
        try body_buf.appendSlice(allocator, "&EndDateType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(allocator, "&InstanceCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(allocator, "&InstanceMatchCriteria=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.quote_id) |v| {
        try body_buf.appendSlice(allocator, "&QuoteId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.start_date) |v| {
        try body_buf.appendSlice(allocator, "&StartDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCapacityReservationOutput {
    _ = status;
    _ = headers;
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
                if (std.mem.eql(u8, e.local, "adjustmentDetails")) {
                    result.adjustment_details = try serde.deserializeCapacityReservationAdjustmentDetails(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "adjustmentStatus")) {
                    result.adjustment_status = CapacityReservationAdjustmentStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "return")) {
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
