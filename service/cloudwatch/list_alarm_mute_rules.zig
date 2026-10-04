const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmMuteRuleStatus = @import("alarm_mute_rule_status.zig").AlarmMuteRuleStatus;
const AlarmMuteRuleSummary = @import("alarm_mute_rule_summary.zig").AlarmMuteRuleSummary;
const serde = @import("serde.zig");

pub const ListAlarmMuteRulesInput = struct {
    /// Filter results to show only mute rules that target the specified alarm name.
    alarm_name: ?[]const u8 = null,

    /// The maximum number of mute rules to return in one call. The default is 50.
    max_records: ?i32 = null,

    /// The token returned from a previous call to indicate where to continue
    /// retrieving results.
    next_token: ?[]const u8 = null,

    /// Filter results to show only mute rules with the specified statuses. Valid
    /// values are `SCHEDULED`, `ACTIVE`, or `EXPIRED`.
    statuses: ?[]const AlarmMuteRuleStatus = null,

    pub const json_field_names = .{
        .alarm_name = "AlarmName",
        .max_records = "MaxRecords",
        .next_token = "NextToken",
        .statuses = "Statuses",
    };
};

pub const ListAlarmMuteRulesOutput = struct {
    /// A list of alarm mute rule summaries.
    alarm_mute_rule_summaries: ?[]const AlarmMuteRuleSummary = null,

    /// The token to use when requesting the next set of results. If this field is
    /// absent, there are no more results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_mute_rule_summaries = "AlarmMuteRuleSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAlarmMuteRulesInput, options: CallOptions) !ListAlarmMuteRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAlarmMuteRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListAlarmMuteRules&Version=2010-08-01");
    if (input.alarm_name) |v| {
        try body_buf.appendSlice(allocator, "&AlarmName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.statuses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Statuses.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAlarmMuteRulesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListAlarmMuteRulesResult")) break;
            },
            else => {},
        }
    }

    var result: ListAlarmMuteRulesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmMuteRuleSummaries")) {
                    result.alarm_mute_rule_summaries = try serde.deserializeAlarmMuteRuleSummaries(allocator, &reader, "member");
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
