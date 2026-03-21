const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const SlotDateTimeRangeRequest = @import("slot_date_time_range_request.zig").SlotDateTimeRangeRequest;
const ScheduledInstanceRecurrenceRequest = @import("scheduled_instance_recurrence_request.zig").ScheduledInstanceRecurrenceRequest;
const ScheduledInstanceAvailability = @import("scheduled_instance_availability.zig").ScheduledInstanceAvailability;
const serde = @import("serde.zig");

pub const DescribeScheduledInstanceAvailabilityInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `availability-zone` - The Availability Zone (for example, `us-west-2a`).
    ///
    /// * `instance-type` - The instance type (for example, `c4.large`).
    ///
    /// * `platform` - The platform (`Linux/UNIX` or `Windows`).
    filters: ?[]const Filter = null,

    /// The time period for the first schedule to start.
    first_slot_start_time_range: SlotDateTimeRangeRequest,

    /// The maximum number of results to return in a single call.
    /// This value can be between 5 and 300. The default value is 300.
    /// To retrieve the remaining results, make another call with the returned
    /// `NextToken` value.
    max_results: ?i32 = null,

    /// The maximum available duration, in hours. This value must be greater than
    /// `MinSlotDurationInHours`
    /// and less than 1,720.
    max_slot_duration_in_hours: ?i32 = null,

    /// The minimum available duration, in hours. The minimum required duration is
    /// 1,200 hours per year. For example, the minimum daily schedule is 4 hours,
    /// the minimum weekly schedule is 24 hours, and the minimum monthly schedule is
    /// 100 hours.
    min_slot_duration_in_hours: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The schedule recurrence.
    recurrence: ScheduledInstanceRecurrenceRequest,
};

pub const DescribeScheduledInstanceAvailabilityOutput = struct {
    /// The token required to retrieve the next set of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the available Scheduled Instances.
    scheduled_instance_availability_set: ?[]const ScheduledInstanceAvailability = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScheduledInstanceAvailabilityInput, options: CallOptions) !DescribeScheduledInstanceAvailabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScheduledInstanceAvailabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeScheduledInstanceAvailability&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
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
    try body_buf.appendSlice(allocator, "&FirstSlotStartTimeRange.EarliestTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.first_slot_start_time_range.earliest_time}) catch "");
    try body_buf.appendSlice(allocator, "&FirstSlotStartTimeRange.LatestTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.first_slot_start_time_range.latest_time}) catch "");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_slot_duration_in_hours) |v| {
        try body_buf.appendSlice(allocator, "&MaxSlotDurationInHours=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_slot_duration_in_hours) |v| {
        try body_buf.appendSlice(allocator, "&MinSlotDurationInHours=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.recurrence.frequency) |sv| {
        try body_buf.appendSlice(allocator, "&Recurrence.Frequency=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.recurrence.interval) |sv| {
        try body_buf.appendSlice(allocator, "&Recurrence.Interval=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.recurrence.occurrence_days) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Recurrence.OccurrenceDay.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item}) catch "");
        }
    }
    if (input.recurrence.occurrence_relative_to_end) |sv| {
        try body_buf.appendSlice(allocator, "&Recurrence.OccurrenceRelativeToEnd=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.recurrence.occurrence_unit) |sv| {
        try body_buf.appendSlice(allocator, "&Recurrence.OccurrenceUnit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScheduledInstanceAvailabilityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeScheduledInstanceAvailabilityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "scheduledInstanceAvailabilitySet")) {
                    result.scheduled_instance_availability_set = try serde.deserializeScheduledInstanceAvailabilitySet(allocator, &reader, "item");
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
