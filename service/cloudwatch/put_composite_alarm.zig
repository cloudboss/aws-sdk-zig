const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const PutCompositeAlarmInput = struct {
    /// Indicates whether actions should be executed during any changes to the alarm
    /// state of
    /// the composite alarm. The default is `TRUE`.
    actions_enabled: ?bool = null,

    /// Actions will be suppressed if the suppressor alarm is in the `ALARM`
    /// state. `ActionsSuppressor` can be an AlarmName or an Amazon Resource Name
    /// (ARN) from an existing alarm.
    actions_suppressor: ?[]const u8 = null,

    /// The maximum time in seconds that the composite alarm waits after suppressor
    /// alarm
    /// goes out of the `ALARM` state. After this time, the composite alarm performs
    /// its actions.
    ///
    /// `ExtensionPeriod` is required only when `ActionsSuppressor` is
    /// specified.
    actions_suppressor_extension_period: ?i32 = null,

    /// The maximum time in seconds that the composite alarm waits for the
    /// suppressor alarm
    /// to go into the `ALARM` state. After this time, the composite alarm performs
    /// its actions.
    ///
    /// `WaitPeriod` is required only when `ActionsSuppressor` is
    /// specified.
    actions_suppressor_wait_period: ?i32 = null,

    /// The actions to execute when this alarm transitions to the `ALARM` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    ///
    /// Valid Values: ]
    ///
    /// **Amazon SNS actions:**
    ///
    /// `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    ///
    /// **Systems Manager actions:**
    ///
    /// `arn:aws:ssm:*region*:*account-id*:opsitem:*severity*
    /// `
    ///
    /// **Start a Amazon Q Developer operational investigation**
    ///
    /// `arn:aws:aiops:*region*:*account-id*:investigation-group:*investigation-group-id*
    /// `
    alarm_actions: ?[]const []const u8 = null,

    /// The description for the composite alarm.
    alarm_description: ?[]const u8 = null,

    /// The name for the composite alarm. This name must be unique within the
    /// Region.
    alarm_name: []const u8,

    /// An expression that specifies which other alarms are to be evaluated to
    /// determine this
    /// composite alarm's state. For each alarm that you reference, you designate a
    /// function
    /// that specifies whether that alarm needs to be in ALARM state, OK state, or
    /// INSUFFICIENT_DATA state. You can use operators (AND, OR and NOT) to combine
    /// multiple
    /// functions in a single expression. You can use parenthesis to logically group
    /// the
    /// functions in your expression.
    ///
    /// You can use either alarm names or ARNs to reference the other alarms that
    /// are to be
    /// evaluated.
    ///
    /// Functions can include the following:
    ///
    /// * `ALARM("*alarm-name* or
    /// *alarm-ARN*")` is TRUE if the named alarm is in
    /// ALARM state.
    ///
    /// * `OK("*alarm-name* or
    /// *alarm-ARN*")` is TRUE if the named alarm is in OK
    /// state.
    ///
    /// * `INSUFFICIENT_DATA("*alarm-name* or
    /// *alarm-ARN*")` is TRUE if the named alarm is in
    /// INSUFFICIENT_DATA state.
    ///
    /// * `TRUE` always evaluates to TRUE.
    ///
    /// * `FALSE` always evaluates to FALSE.
    ///
    /// TRUE and FALSE are useful for testing a complex `AlarmRule` structure, and
    /// for testing your alarm actions.
    ///
    /// Alarm names specified in `AlarmRule` can be surrounded with double-quotes
    /// ("), but do not have to be.
    ///
    /// The following are some examples of `AlarmRule`:
    ///
    /// * `ALARM(CPUUtilizationTooHigh) AND ALARM(DiskReadOpsTooHigh)`
    /// specifies that the composite alarm goes into ALARM state only if both
    /// CPUUtilizationTooHigh and DiskReadOpsTooHigh alarms are in ALARM state.
    ///
    /// * `ALARM(CPUUtilizationTooHigh) AND NOT ALARM(DeploymentInProgress)`
    /// specifies that the alarm goes to ALARM state if CPUUtilizationTooHigh is in
    /// ALARM state and DeploymentInProgress is not in ALARM state. This example
    /// reduces
    /// alarm noise during a known deployment window.
    ///
    /// * `(ALARM(CPUUtilizationTooHigh) OR ALARM(DiskReadOpsTooHigh)) AND
    /// OK(NetworkOutTooHigh)` goes into ALARM state if CPUUtilizationTooHigh
    /// OR DiskReadOpsTooHigh is in ALARM state, and if NetworkOutTooHigh is in OK
    /// state. This provides another example of using a composite alarm to prevent
    /// noise. This rule ensures that you are not notified with an alarm action on
    /// high
    /// CPU or disk usage if a known network problem is also occurring.
    ///
    /// The `AlarmRule` can specify as many as 100 "children" alarms. The
    /// `AlarmRule` expression can have as many as 500 elements. Elements are
    /// child alarms, TRUE or FALSE statements, and parentheses.
    alarm_rule: []const u8,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state from any other state. Each action is specified
    /// as an Amazon Resource Name (ARN).
    ///
    /// Valid Values: ]
    ///
    /// **Amazon SNS actions:**
    ///
    /// `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    insufficient_data_actions: ?[]const []const u8 = null,

    /// The actions to execute when this alarm transitions to an `OK` state from
    /// any other state. Each action is specified as an Amazon Resource Name (ARN).
    ///
    /// Valid Values: ]
    ///
    /// **Amazon SNS actions:**
    ///
    /// `arn:aws:sns:*region*:*account-id*:*sns-topic-name*
    /// `
    ///
    /// **Lambda actions:**
    ///
    /// * Invoke the latest version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*
    /// `
    ///
    /// * Invoke a specific version of a Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*version-number*
    /// `
    ///
    /// * Invoke a function by using an alias Lambda function:
    /// `arn:aws:lambda:*region*:*account-id*:function:*function-name*:*alias-name*
    /// `
    ok_actions: ?[]const []const u8 = null,

    /// A list of key-value pairs to associate with the alarm. You can associate as
    /// many as
    /// 50 tags with an alarm. To be able to associate tags with the alarm when you
    /// create the
    /// alarm, you must have the `cloudwatch:TagResource` permission.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions by granting a user permission to access or change
    /// only resources
    /// with certain tag values.
    ///
    /// If you are using this operation to update an existing alarm, any tags you
    /// specify in
    /// this parameter are ignored. To change the tags of an existing alarm, use
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_TagResource.html) or [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UntagResource.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .actions_enabled = "ActionsEnabled",
        .actions_suppressor = "ActionsSuppressor",
        .actions_suppressor_extension_period = "ActionsSuppressorExtensionPeriod",
        .actions_suppressor_wait_period = "ActionsSuppressorWaitPeriod",
        .alarm_actions = "AlarmActions",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .alarm_rule = "AlarmRule",
        .insufficient_data_actions = "InsufficientDataActions",
        .ok_actions = "OKActions",
        .tags = "Tags",
    };
};

pub const PutCompositeAlarmOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutCompositeAlarmInput, options: CallOptions) !PutCompositeAlarmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "monitoring");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutCompositeAlarmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutCompositeAlarm&Version=2010-08-01");
    if (input.actions_enabled) |v| {
        try body_buf.appendSlice(allocator, "&ActionsEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.actions_suppressor) |v| {
        try body_buf.appendSlice(allocator, "&ActionsSuppressor=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.actions_suppressor_extension_period) |v| {
        try body_buf.appendSlice(allocator, "&ActionsSuppressorExtensionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.actions_suppressor_wait_period) |v| {
        try body_buf.appendSlice(allocator, "&ActionsSuppressorWaitPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.alarm_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AlarmActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.alarm_description) |v| {
        try body_buf.appendSlice(allocator, "&AlarmDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&AlarmName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_name);
    try body_buf.appendSlice(allocator, "&AlarmRule=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.alarm_rule);
    if (input.insufficient_data_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InsufficientDataActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.ok_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OKActions.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutCompositeAlarmOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutCompositeAlarmOutput = .{};

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
