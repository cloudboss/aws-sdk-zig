const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceEventWindowTimeRangeRequest = @import("instance_event_window_time_range_request.zig").InstanceEventWindowTimeRangeRequest;
const InstanceEventWindow = @import("instance_event_window.zig").InstanceEventWindow;

/// Modifies the specified event window.
///
/// You can define either a set of time ranges or a cron expression when
/// modifying the event
/// window, but not both.
///
/// To modify the targets associated with the event window, use the
/// AssociateInstanceEventWindow and DisassociateInstanceEventWindow API.
///
/// If Amazon Web Services has already scheduled an event, modifying an event
/// window won't change the time
/// of the scheduled event.
///
/// For more information, see [Define event windows for scheduled
/// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
pub const ModifyInstanceEventWindowInput = struct {
    /// The cron expression of the event window, for example, `* 0-4,20-23 * *
    /// 1,5`.
    ///
    /// Constraints:
    ///
    /// * Only hour and day of the week values are supported.
    ///
    /// * For day of the week values, you can specify either integers `0` through
    /// `6`, or alternative single values `SUN` through
    /// `SAT`.
    ///
    /// * The minute, month, and year must be specified by `*`.
    ///
    /// * The hour value must be one or a multiple range, for example, `0-4` or
    /// `0-4,20-23`.
    ///
    /// * Each hour range must be >= 2 hours, for example, `0-2` or
    /// `20-23`.
    ///
    /// * The event window must be >= 4 hours. The combined total time ranges in the
    ///   event
    /// window must be >= 4 hours.
    ///
    /// For more information about cron expressions, see
    /// [cron](https://en.wikipedia.org/wiki/Cron) on the *Wikipedia
    /// website*.
    cron_expression: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the event window.
    instance_event_window_id: []const u8,

    /// The name of the event window.
    name: ?[]const u8 = null,

    /// The time ranges of the event window.
    time_ranges: ?[]const InstanceEventWindowTimeRangeRequest = null,
};

pub const ModifyInstanceEventWindowOutput = struct {
    /// Information about the event window.
    instance_event_window: ?InstanceEventWindow = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyInstanceEventWindowOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstanceEventWindowInput, options: Options) !ModifyInstanceEventWindowOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceEventWindowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceEventWindow&Version=2016-11-15");
    if (input.cron_expression) |v| {
        try body_buf.appendSlice(alloc, "&CronExpression=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceEventWindowId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_event_window_id);
    if (input.name) |v| {
        try body_buf.appendSlice(alloc, "&Name=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.time_ranges) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRanges.member.{d}.EndHour=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.end_hour) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRanges.member.{d}.EndWeekDay=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.end_week_day) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRanges.member.{d}.StartHour=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.start_hour) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRanges.member.{d}.StartWeekDay=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.start_week_day) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyInstanceEventWindowOutput {
    _ = status;
    _ = body;
    const result: ModifyInstanceEventWindowOutput = .{ .allocator = alloc };

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
