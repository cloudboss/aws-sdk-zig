const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmType = @import("alarm_type.zig").AlarmType;
const HistoryItemType = @import("history_item_type.zig").HistoryItemType;
const ScanBy = @import("scan_by.zig").ScanBy;
const AlarmHistoryItem = @import("alarm_history_item.zig").AlarmHistoryItem;
const serde = @import("serde.zig");

pub const DescribeAlarmHistoryInput = struct {
    /// The unique identifier of a specific alarm contributor to filter the alarm
    /// history results.
    alarm_contributor_id: ?[]const u8 = null,

    /// The name of the alarm.
    alarm_name: ?[]const u8 = null,

    /// Use this parameter to specify whether you want the operation to return
    /// metric alarms
    /// or composite alarms. If you omit this parameter, only metric alarms are
    /// returned.
    alarm_types: ?[]const AlarmType = null,

    /// The ending date to retrieve alarm history.
    end_date: ?i64 = null,

    /// The type of alarm histories to retrieve.
    history_item_type: ?HistoryItemType = null,

    /// The maximum number of alarm history records to retrieve.
    max_records: ?i32 = null,

    /// The token returned by a previous call to indicate that there is more data
    /// available.
    next_token: ?[]const u8 = null,

    /// Specified whether to return the newest or oldest alarm history first.
    /// Specify
    /// `TimestampDescending` to have the newest event history returned first,
    /// and specify `TimestampAscending` to have the oldest history returned
    /// first.
    scan_by: ?ScanBy = null,

    /// The starting date to retrieve alarm history.
    start_date: ?i64 = null,

    pub const json_field_names = .{
        .alarm_contributor_id = "AlarmContributorId",
        .alarm_name = "AlarmName",
        .alarm_types = "AlarmTypes",
        .end_date = "EndDate",
        .history_item_type = "HistoryItemType",
        .max_records = "MaxRecords",
        .next_token = "NextToken",
        .scan_by = "ScanBy",
        .start_date = "StartDate",
    };
};

pub const DescribeAlarmHistoryOutput = struct {
    /// The alarm histories, in JSON format.
    alarm_history_items: ?[]const AlarmHistoryItem = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_history_items = "AlarmHistoryItems",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlarmHistoryInput, options: CallOptions) !DescribeAlarmHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlarmHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAlarmHistory&Version=2010-08-01");
    if (input.alarm_contributor_id) |v| {
        try body_buf.appendSlice(allocator, "&AlarmContributorId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.alarm_name) |v| {
        try body_buf.appendSlice(allocator, "&AlarmName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.alarm_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AlarmTypes.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(allocator, "&EndDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.history_item_type) |v| {
        try body_buf.appendSlice(allocator, "&HistoryItemType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.scan_by) |v| {
        try body_buf.appendSlice(allocator, "&ScanBy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAlarmHistoryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAlarmHistoryResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAlarmHistoryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmHistoryItems")) {
                    result.alarm_history_items = try serde.deserializeAlarmHistoryItems(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
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
