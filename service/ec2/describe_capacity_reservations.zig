const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const CapacityReservation = @import("capacity_reservation.zig").CapacityReservation;

/// Describes one or more of your Capacity Reservations. The results describe
/// only the
/// Capacity Reservations in the Amazon Web Services Region that you're
/// currently
/// using.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeCapacityReservationsOutput) void {
        if (self.next_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeCapacityReservationsInput, options: Options) !DescribeCapacityReservationsOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeCapacityReservationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeCapacityReservations&Version=2016-11-15");
    if (input.capacity_reservation_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CapacityReservationIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !DescribeCapacityReservationsOutput {
    _ = status;
    var result: DescribeCapacityReservationsOutput = .{ .allocator = alloc };
    if (findElement(body, "nextToken")) |content| {
        result.next_token = try alloc.dupe(u8, content);
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
