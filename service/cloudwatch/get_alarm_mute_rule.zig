const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MuteTargets = @import("mute_targets.zig").MuteTargets;
const Rule = @import("rule.zig").Rule;
const AlarmMuteRuleStatus = @import("alarm_mute_rule_status.zig").AlarmMuteRuleStatus;
const serde = @import("serde.zig");

pub const GetAlarmMuteRuleInput = struct {
    /// The name of the alarm mute rule to retrieve.
    alarm_mute_rule_name: []const u8,

    pub const json_field_names = .{
        .alarm_mute_rule_name = "AlarmMuteRuleName",
    };
};

pub const GetAlarmMuteRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the alarm mute rule.
    alarm_mute_rule_arn: ?[]const u8 = null,

    /// The description of the alarm mute rule.
    description: ?[]const u8 = null,

    /// The date and time when the mute rule expires and is no longer evaluated.
    expire_date: ?i64 = null,

    /// The date and time when the mute rule was last updated.
    last_updated_timestamp: ?i64 = null,

    /// Specifies which alarms this rule applies to.
    mute_targets: ?MuteTargets = null,

    /// Indicates whether the mute rule is one-time or recurring. Valid values are
    /// `ONE_TIME` or `RECURRING`.
    mute_type: ?[]const u8 = null,

    /// The name of the alarm mute rule.
    name: ?[]const u8 = null,

    /// The configuration that defines when and how long alarms are muted.
    rule: ?Rule = null,

    /// The date and time when the mute rule becomes active. If not set, the rule is
    /// active
    /// immediately.
    start_date: ?i64 = null,

    /// The current status of the alarm mute rule. Valid values are `SCHEDULED`,
    /// `ACTIVE`, or `EXPIRED`.
    status: ?AlarmMuteRuleStatus = null,

    pub const json_field_names = .{
        .alarm_mute_rule_arn = "AlarmMuteRuleArn",
        .description = "Description",
        .expire_date = "ExpireDate",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .mute_targets = "MuteTargets",
        .mute_type = "MuteType",
        .name = "Name",
        .rule = "Rule",
        .start_date = "StartDate",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAlarmMuteRuleInput, options: CallOptions) !GetAlarmMuteRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAlarmMuteRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetAlarmMuteRule&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&AlarmMuteRuleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_mute_rule_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAlarmMuteRuleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetAlarmMuteRuleResult")) break;
            },
            else => {},
        }
    }

    var result: GetAlarmMuteRuleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmMuteRuleArn")) {
                    result.alarm_mute_rule_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpireDate")) {
                    result.expire_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MuteTargets")) {
                    result.mute_targets = try serde.deserializeMuteTargets(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "MuteType")) {
                    result.mute_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Rule")) {
                    result.rule = try serde.deserializeRule(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "StartDate")) {
                    result.start_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = AlarmMuteRuleStatus.fromWireName(try reader.readElementText());
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
