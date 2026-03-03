const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlarmType = @import("alarm_type.zig").AlarmType;
const StateValue = @import("state_value.zig").StateValue;
const CompositeAlarm = @import("composite_alarm.zig").CompositeAlarm;
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
    /// metric alarms
    /// or composite alarms. If you omit this parameter, only metric alarms are
    /// returned, even
    /// if composite alarms exist in the account.
    ///
    /// For example, if you omit this parameter or specify `MetricAlarms`, the
    /// operation returns only a list of metric alarms. It does not return any
    /// composite alarms,
    /// even if composite alarms exist in the account.
    ///
    /// If you specify `CompositeAlarms`, the operation returns only a list of
    /// composite alarms, and does not return any metric alarms.
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

    /// The information about any metric alarms returned by the operation.
    metric_alarms: ?[]const MetricAlarm = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .composite_alarms = "CompositeAlarms",
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlarmsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

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
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardInvalidInputError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_invalid_input_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFormatFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_format_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
