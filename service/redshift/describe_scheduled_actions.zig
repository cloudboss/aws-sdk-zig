const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledActionFilter = @import("scheduled_action_filter.zig").ScheduledActionFilter;
const ScheduledActionTypeValues = @import("scheduled_action_type_values.zig").ScheduledActionTypeValues;
const ScheduledAction = @import("scheduled_action.zig").ScheduledAction;
const serde = @import("serde.zig");

pub const DescribeScheduledActionsInput = struct {
    /// If true, retrieve only active scheduled actions.
    /// If false, retrieve only disabled scheduled actions.
    active: ?bool = null,

    /// The end time in UTC of the scheduled action to retrieve.
    /// Only active scheduled actions that have invocations before this time are
    /// retrieved.
    end_time: ?i64 = null,

    /// List of scheduled action filters.
    filters: ?[]const ScheduledActionFilter = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeScheduledActions request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    ///
    /// Default: `100`
    ///
    /// Constraints: minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The name of the scheduled action to retrieve.
    scheduled_action_name: ?[]const u8 = null,

    /// The start time in UTC of the scheduled actions to retrieve.
    /// Only active scheduled actions that have invocations after this time are
    /// retrieved.
    start_time: ?i64 = null,

    /// The type of the scheduled actions to retrieve.
    target_action_type: ?ScheduledActionTypeValues = null,
};

pub const DescribeScheduledActionsOutput = struct {
    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeScheduledActions request
    /// exceed the value specified in `MaxRecords`, Amazon Web Services returns a
    /// value in the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// List of retrieved scheduled actions.
    scheduled_actions: ?[]const ScheduledAction = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScheduledActionsInput, options: CallOptions) !DescribeScheduledActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScheduledActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeScheduledActions&Version=2012-12-01");
    if (input.active) |v| {
        try body_buf.appendSlice(allocator, "&Active=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.ScheduledActionFilter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name.wireName());
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.ScheduledActionFilter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.scheduled_action_name) |v| {
        try body_buf.appendSlice(allocator, "&ScheduledActionName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.target_action_type) |v| {
        try body_buf.appendSlice(allocator, "&TargetActionType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScheduledActionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeScheduledActionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeScheduledActionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScheduledActions")) {
                    result.scheduled_actions = try serde.deserializeScheduledActionList(allocator, &reader, "ScheduledAction");
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
