const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const CapacityReservation = @import("capacity_reservation.zig").CapacityReservation;
const serde = @import("serde.zig");

pub const DescribeCapacityReservationsInput = struct {
    /// The ID of the Capacity Reservation.
    capacity_reservation_ids: ?[]const []const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters.
    ///
    /// * `instance-type` - The type of instance for which the Capacity
    /// Reservation reserves capacity.
    ///
    /// * `owner-id` - The ID of the Amazon Web Services account that owns the
    /// Capacity Reservation.
    ///
    /// * `instance-platform` - The type of operating system for which the
    /// Capacity Reservation reserves capacity.
    ///
    /// * `availability-zone` - The Availability Zone of the Capacity
    /// Reservation.
    ///
    /// * `tenancy` - Indicates the tenancy of the Capacity Reservation. A
    /// Capacity Reservation can have one of the following tenancy settings:
    ///
    /// * `default` - The Capacity Reservation is created on hardware
    /// that is shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Reservation is created on
    /// single-tenant hardware that is dedicated to a single Amazon Web Services
    /// account.
    ///
    /// * `outpost-arn` - The Amazon Resource Name (ARN) of the Outpost on
    /// which the Capacity Reservation was created.
    ///
    /// * `state` - The current state of the Capacity Reservation. A Capacity
    /// Reservation can be in one of the following states:
    ///
    /// * `active`- The Capacity Reservation is active and the
    /// capacity is available for your use.
    ///
    /// * `expired` - The Capacity Reservation expired automatically
    /// at the date and time specified in your request. The reserved capacity is
    /// no longer available for your use.
    ///
    /// * `cancelled` - The Capacity Reservation was cancelled. The
    /// reserved capacity is no longer available for your use.
    ///
    /// * `pending` - The Capacity Reservation request was successful
    /// but the capacity provisioning is still pending.
    ///
    /// * `failed` - The Capacity Reservation request has failed. A
    /// request might fail due to invalid request parameters, capacity
    /// constraints, or instance limit constraints. Failed requests are retained
    /// for 60 minutes.
    ///
    /// * `start-date` - The date and time at which the Capacity Reservation
    /// was started.
    ///
    /// * `end-date` - The date and time at which the Capacity Reservation
    /// expires. When a Capacity Reservation expires, the reserved capacity is
    /// released
    /// and you can no longer launch instances into it. The Capacity Reservation's
    /// state
    /// changes to expired when it reaches its end date and time.
    ///
    /// * `end-date-type` - Indicates the way in which the Capacity
    /// Reservation ends. A Capacity Reservation can have one of the following end
    /// types:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until
    /// you explicitly cancel it.
    ///
    /// * `limited` - The Capacity Reservation expires automatically
    /// at a specified date and time.
    ///
    /// * `instance-match-criteria` - Indicates the type of instance launches
    /// that the Capacity Reservation accepts. The options include:
    ///
    /// * `open` - The Capacity Reservation accepts all instances
    /// that have matching attributes (instance type, platform, and Availability
    /// Zone). Instances that have matching attributes launch into the Capacity
    /// Reservation automatically without specifying any additional
    /// parameters.
    ///
    /// * `targeted` - The Capacity Reservation only accepts
    /// instances that have matching attributes (instance type, platform, and
    /// Availability Zone), and explicitly target the Capacity Reservation. This
    /// ensures that only permitted instances can use the reserved
    /// capacity.
    ///
    /// * `placement-group-arn` - The ARN of the cluster placement group in
    /// which the Capacity Reservation was created.
    filters: ?[]const Filter = null,

    /// The maximum number of items to return for this request. To get the next page
    /// of items, make another request with the token returned in the output. For
    /// more information,
    /// see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,
};

pub const DescribeCapacityReservationsOutput = struct {
    /// Information about the Capacity Reservations.
    capacity_reservations: ?[]const CapacityReservation = null,

    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCapacityReservationsInput, options: CallOptions) !DescribeCapacityReservationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCapacityReservationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeCapacityReservations&Version=2016-11-15");
    if (input.capacity_reservation_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CapacityReservationId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Value.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCapacityReservationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeCapacityReservationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "capacityReservationSet")) {
                    result.capacity_reservations = try serde.deserializeCapacityReservationSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
