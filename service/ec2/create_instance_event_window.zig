const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const InstanceEventWindowTimeRangeRequest = @import("instance_event_window_time_range_request.zig").InstanceEventWindowTimeRangeRequest;
const InstanceEventWindow = @import("instance_event_window.zig").InstanceEventWindow;
const serde = @import("serde.zig");

pub const CreateInstanceEventWindowInput = struct {
    /// The cron expression for the event window, for example, `* 0-4,20-23 * *
    /// 1,5`.
    /// If you specify a cron expression, you can't specify a time range.
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

    /// The name of the event window.
    name: ?[]const u8 = null,

    /// The tags to apply to the event window.
    tag_specifications: ?[]const TagSpecification = null,

    /// The time range for the event window. If you specify a time range, you can't
    /// specify a
    /// cron expression.
    time_ranges: ?[]const InstanceEventWindowTimeRangeRequest = null,
};

pub const CreateInstanceEventWindowOutput = struct {
    /// Information about the event window.
    instance_event_window: ?InstanceEventWindow = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateInstanceEventWindowOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateInstanceEventWindowInput, options: Options) !CreateInstanceEventWindowOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInstanceEventWindowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateInstanceEventWindow&Version=2016-11-15");
    if (input.cron_expression) |v| {
        try body_buf.appendSlice(alloc, "&CronExpression=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.name) |v| {
        try body_buf.appendSlice(alloc, "&Name=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.time_ranges) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRange.member.{d}.EndHour=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.end_hour) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRange.member.{d}.EndWeekDay=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.end_week_day) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRange.member.{d}.StartHour=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.start_hour) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TimeRange.member.{d}.StartWeekDay=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.start_week_day) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInstanceEventWindowOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateInstanceEventWindowOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceEventWindow")) {
                    result.instance_event_window = try serde.deserializeInstanceEventWindow(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
