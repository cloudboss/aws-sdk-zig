const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplyCancellationCharges = @import("apply_cancellation_charges.zig").ApplyCancellationCharges;

pub const CancelCapacityReservationInput = struct {
    /// Specifies the cancellation charge type to apply when cancelling a
    /// future-dated Capacity
    /// Reservation during its commitment duration. Possible values include
    /// `commitment-wind-down`, which continues billing for the remaining commitment
    /// duration without delivering capacity.
    apply_cancellation_charges: ?ApplyCancellationCharges = null,

    /// The ID of the Capacity Reservation to be cancelled.
    capacity_reservation_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the cancellation quote to use for the cancellation. You can
    /// generate a
    /// cancellation quote by using the `CreateCapacityReservationCancellationQuote`
    /// action. The cancellation quote must be in an `active` state.
    quote_id: ?[]const u8 = null,
};

pub const CancelCapacityReservationOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelCapacityReservationInput, options: CallOptions) !CancelCapacityReservationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CancelCapacityReservation&Version=2016-11-15");
    if (input.apply_cancellation_charges) |v| {
        try body_buf.appendSlice(allocator, "&ApplyCancellationCharges=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.quote_id) |v| {
        try body_buf.appendSlice(allocator, "&QuoteId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelCapacityReservationOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CancelCapacityReservationOutput = .{};
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
