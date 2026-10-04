const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MuteTargets = @import("mute_targets.zig").MuteTargets;
const Rule = @import("rule.zig").Rule;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const PutAlarmMuteRuleInput = struct {
    /// A description of the alarm mute rule that helps you identify its purpose.
    description: ?[]const u8 = null,

    /// The date and time when the mute rule expires and is no longer evaluated,
    /// specified as a timestamp in ISO 8601 format (for example,
    /// `2026-12-31T23:59:59Z`). After this time, the rule status becomes EXPIRED
    /// and will no longer mute the targeted alarms.
    expire_date: ?i64 = null,

    /// Specifies which alarms this rule applies to.
    mute_targets: ?MuteTargets = null,

    /// The name of the alarm mute rule. This name must be unique within your Amazon
    /// Web Services account and region.
    name: []const u8,

    /// The configuration that defines when and how long alarms should be muted.
    rule: Rule,

    /// The date and time after which the mute rule takes effect, specified as a
    /// timestamp in ISO 8601 format (for example, `2026-04-15T08:00:00Z`). If not
    /// specified, the mute rule takes effect immediately upon creation and the
    /// mutes are applied as per the schedule expression.
    start_date: ?i64 = null,

    /// A list of key-value pairs to associate with the alarm mute rule. You can use
    /// tags to categorize and manage your mute rules.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .expire_date = "ExpireDate",
        .mute_targets = "MuteTargets",
        .name = "Name",
        .rule = "Rule",
        .start_date = "StartDate",
        .tags = "Tags",
    };
};

pub const PutAlarmMuteRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAlarmMuteRuleInput, options: CallOptions) !PutAlarmMuteRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAlarmMuteRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutAlarmMuteRule&Version=2010-08-01");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.expire_date) |v| {
        try body_buf.appendSlice(allocator, "&ExpireDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.mute_targets) |v| {
        for (v.alarm_names, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MuteTargets.AlarmNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "&Rule.Schedule.Duration=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule.schedule.duration);
    try body_buf.appendSlice(allocator, "&Rule.Schedule.Expression=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule.schedule.expression);
    if (input.rule.schedule.timezone) |sv2| {
        try body_buf.appendSlice(allocator, "&Rule.Schedule.Timezone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
    }
    if (input.start_date) |v| {
        try body_buf.appendSlice(allocator, "&StartDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAlarmMuteRuleOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutAlarmMuteRuleOutput = .{};

    return result;
}
