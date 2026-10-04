const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmType = @import("alarm_type.zig").AlarmType;
const StateValue = @import("state_value.zig").StateValue;
const CompositeAlarm = @import("composite_alarm.zig").CompositeAlarm;
const LogAlarm = @import("log_alarm.zig").LogAlarm;
const MetricAlarm = @import("metric_alarm.zig").MetricAlarm;
const serde = @import("serde.zig");

pub const DescribeAlarmsInput = struct {
    /// Use this parameter to filter the results of the operation to only those
    /// alarms that
    /// use a certain alarm action. For example, you could specify the ARN of an SNS
    /// topic to
    /// find all alarms that send notifications to that topic.
    action_prefix: ?[]const u8 = null,

    /// An alarm name prefix. If you specify this parameter, you receive information
    /// about
    /// all alarms that have names that start with this prefix.
    ///
    /// If this parameter is specified, you cannot specify
    /// `AlarmNames`.
    alarm_name_prefix: ?[]const u8 = null,

    /// The names of the alarms to retrieve information about.
    alarm_names: ?[]const []const u8 = null,

    /// Use this parameter to specify whether you want the operation to return
    /// metric alarms,
    /// composite alarms, or log alarms. If you omit this parameter, only metric
    /// alarms are
    /// returned, even if composite alarms or log alarms exist in the account.
    ///
    /// For example, if you omit this parameter or specify `MetricAlarms`, the
    /// operation returns only a list of metric alarms. It does not return any
    /// composite alarms
    /// or log alarms, even if they exist in the account.
    ///
    /// If you specify `CompositeAlarms`, the operation returns only a list of
    /// composite alarms, and does not return any metric alarms or log alarms.
    ///
    /// If you specify `LogAlarms`, the operation returns only a list of log
    /// alarms, and does not return any metric alarms or composite alarms.
    alarm_types: ?[]const AlarmType = null,

    /// If you use this parameter and specify the name of a composite alarm, the
    /// operation
    /// returns information about the "children" alarms of the alarm you specify.
    /// These are the
    /// metric alarms and composite alarms referenced in the `AlarmRule` field of
    /// the
    /// composite alarm that you specify in `ChildrenOfAlarmName`. Information about
    /// the composite alarm that you name in `ChildrenOfAlarmName` is not
    /// returned.
    ///
    /// If you specify `ChildrenOfAlarmName`, you cannot specify any other
    /// parameters in the request except for `MaxRecords` and `NextToken`.
    /// If you do so, you receive a validation error.
    ///
    /// Only the `Alarm Name`, `ARN`, `StateValue`
    /// (OK/ALARM/INSUFFICIENT_DATA), and `StateUpdatedTimestamp` information are
    /// returned by this operation when you use this parameter. To get complete
    /// information
    /// about these alarms, perform another `DescribeAlarms` operation and
    /// specify the parent alarm names in the `AlarmNames` parameter.
    children_of_alarm_name: ?[]const u8 = null,

    /// The maximum number of alarm descriptions to retrieve.
    max_records: ?i32 = null,

    /// The token returned by a previous call to indicate that there is more data
    /// available.
    next_token: ?[]const u8 = null,

    /// If you use this parameter and specify the name of a metric or composite
    /// alarm, the
    /// operation returns information about the "parent" alarms of the alarm you
    /// specify. These
    /// are the composite alarms that have `AlarmRule` parameters that reference the
    /// alarm named in `ParentsOfAlarmName`. Information about the alarm that you
    /// specify in `ParentsOfAlarmName` is not returned.
    ///
    /// If you specify `ParentsOfAlarmName`, you cannot specify any other
    /// parameters in the request except for `MaxRecords` and `NextToken`.
    /// If you do so, you receive a validation error.
    ///
    /// Only the Alarm Name and ARN are returned by this operation when you use this
    /// parameter. To get complete information about these alarms, perform another
    /// `DescribeAlarms` operation and specify the parent alarm names in the
    /// `AlarmNames` parameter.
    parents_of_alarm_name: ?[]const u8 = null,

    /// Specify this parameter to receive information only about alarms that are
    /// currently
    /// in the state that you specify.
    state_value: ?StateValue = null,

    pub const json_field_names = .{
        .action_prefix = "ActionPrefix",
        .alarm_name_prefix = "AlarmNamePrefix",
        .alarm_names = "AlarmNames",
        .alarm_types = "AlarmTypes",
        .children_of_alarm_name = "ChildrenOfAlarmName",
        .max_records = "MaxRecords",
        .next_token = "NextToken",
        .parents_of_alarm_name = "ParentsOfAlarmName",
        .state_value = "StateValue",
    };
};

pub const DescribeAlarmsOutput = struct {
    /// The information about any composite alarms returned by the operation.
    composite_alarms: ?[]const CompositeAlarm = null,

    /// The information about any log alarms returned by the operation.
    log_alarms: ?[]const LogAlarm = null,

    /// The information about any metric alarms returned by the operation.
    metric_alarms: ?[]const MetricAlarm = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .composite_alarms = "CompositeAlarms",
        .log_alarms = "LogAlarms",
        .metric_alarms = "MetricAlarms",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlarmsInput, options: CallOptions) !DescribeAlarmsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlarmsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAlarms&Version=2010-08-01");
    if (input.action_prefix) |v| {
        try body_buf.appendSlice(allocator, "&ActionPrefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.alarm_name_prefix) |v| {
        try body_buf.appendSlice(allocator, "&AlarmNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.alarm_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AlarmNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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
    if (input.children_of_alarm_name) |v| {
        try body_buf.appendSlice(allocator, "&ChildrenOfAlarmName=");
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
    if (input.parents_of_alarm_name) |v| {
        try body_buf.appendSlice(allocator, "&ParentsOfAlarmName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.state_value) |v| {
        try body_buf.appendSlice(allocator, "&StateValue=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAlarmsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAlarmsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAlarmsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CompositeAlarms")) {
                    result.composite_alarms = try serde.deserializeCompositeAlarms(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "LogAlarms")) {
                    result.log_alarms = try serde.deserializeLogAlarms(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricAlarms")) {
                    result.metric_alarms = try serde.deserializeMetricAlarms(allocator, &reader, "member");
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
