const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const ScheduledQueryConfiguration = @import("scheduled_query_configuration.zig").ScheduledQueryConfiguration;
const Tag = @import("tag.zig").Tag;
const WarmUpConfiguration = @import("warm_up_configuration.zig").WarmUpConfiguration;
const serde = @import("serde.zig");

pub const PutLogAlarmInput = struct {
    /// The number of log lines from the most recent scheduled query execution to
    /// include in alarm action notifications. Valid range is 0 through 50. The
    /// default is 0, which means no log lines are included.
    action_log_line_count: ?i32 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that CloudWatch assumes to
    /// retrieve log events for inclusion in alarm action notifications. Required
    /// when `ActionLogLineCount` is greater than 0.
    action_log_line_role_arn: ?[]const u8 = null,

    /// Indicates whether actions should be executed during any changes to the alarm
    /// state. The default is `true`.
    actions_enabled: ?bool = null,

    /// The actions to execute when this alarm transitions to the `ALARM` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    ///
    /// Valid Values:
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
    alarm_actions: ?[]const []const u8 = null,

    /// The description for the alarm.
    alarm_description: ?[]const u8 = null,

    /// The name for the alarm. This name must be unique within the Amazon Web
    /// Services account and Region.
    alarm_name: []const u8,

    /// The arithmetic operation to use when comparing the aggregated query result
    /// and the threshold. The aggregated query result is used as the first operand.
    /// Valid values are `GreaterThanThreshold`, `GreaterThanOrEqualToThreshold`,
    /// `LessThanThreshold`, and `LessThanOrEqualToThreshold`.
    comparison_operator: ComparisonOperator,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    ///
    /// Valid Values:
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

    /// The actions to execute when this alarm transitions to the `OK` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    ///
    /// Valid Values:
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

    /// The number of query results, out of the most recent `QueryResultsToEvaluate`
    /// results, that must breach the threshold to trigger the alarm to transition
    /// to `ALARM` (the M in M-of-N evaluation). Must be less than or equal to
    /// `QueryResultsToEvaluate`.
    query_results_to_alarm: i32,

    /// The number of most recent scheduled query results to evaluate against the
    /// threshold (the N in M-of-N evaluation). Valid range is 1 through 100.
    query_results_to_evaluate: i32,

    /// The configuration of the underlying CloudWatch Logs scheduled query that
    /// this alarm evaluates, including the query string, log groups, schedule, and
    /// aggregation expression.
    scheduled_query_configuration: ScheduledQueryConfiguration,

    /// A list of key-value pairs to associate with the alarm. You can use tags to
    /// categorize and manage your alarms.
    tags: ?[]const Tag = null,

    /// The value to compare with the aggregated query result.
    threshold: f64,

    /// Sets how this alarm is to handle missing data points. Valid values are
    /// `breaching`, `notBreaching`, `ignore`, and `missing`. If this parameter is
    /// omitted, the default behavior of `missing` is used.
    treat_missing_data: ?[]const u8 = null,

    /// The warm-up configuration for the alarm. A warm-up period delays alarm
    /// evaluation
    /// after you create or update the alarm. The warm-up period reduces alarm noise
    /// from
    /// missing data while a new resource or service starts publishing data.
    ///
    /// For more information, see [Alarm warm-up
    /// periods](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/alarm-warm-up.html) in the *Amazon CloudWatch User Guide*.
    warm_up_configuration: ?WarmUpConfiguration = null,

    pub const json_field_names = .{
        .action_log_line_count = "ActionLogLineCount",
        .action_log_line_role_arn = "ActionLogLineRoleArn",
        .actions_enabled = "ActionsEnabled",
        .alarm_actions = "AlarmActions",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .comparison_operator = "ComparisonOperator",
        .insufficient_data_actions = "InsufficientDataActions",
        .ok_actions = "OKActions",
        .query_results_to_alarm = "QueryResultsToAlarm",
        .query_results_to_evaluate = "QueryResultsToEvaluate",
        .scheduled_query_configuration = "ScheduledQueryConfiguration",
        .tags = "Tags",
        .threshold = "Threshold",
        .treat_missing_data = "TreatMissingData",
        .warm_up_configuration = "WarmUpConfiguration",
    };
};

pub const PutLogAlarmOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutLogAlarmInput, options: CallOptions) !PutLogAlarmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutLogAlarmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutLogAlarm&Version=2010-08-01");
    if (input.action_log_line_count) |v| {
        try body_buf.appendSlice(allocator, "&ActionLogLineCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.action_log_line_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&ActionLogLineRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.actions_enabled) |v| {
        try body_buf.appendSlice(allocator, "&ActionsEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    try body_buf.appendSlice(allocator, "&ComparisonOperator=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.comparison_operator.wireName());
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
    try body_buf.appendSlice(allocator, "&QueryResultsToAlarm=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.query_results_to_alarm}) catch "");
    try body_buf.appendSlice(allocator, "&QueryResultsToEvaluate=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.query_results_to_evaluate}) catch "");
    try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.AggregationExpression=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_query_configuration.aggregation_expression);
    if (input.scheduled_query_configuration.log_group_identifiers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledQueryConfiguration.LogGroupIdentifiers.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.scheduled_query_configuration.query_arn) |sv| {
        try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.QueryARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.QueryString=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_query_configuration.query_string);
    if (input.scheduled_query_configuration.schedule_configuration.end_time_offset) |sv2| {
        try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.ScheduleConfiguration.EndTimeOffset=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.ScheduleConfiguration.ScheduleExpression=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_query_configuration.schedule_configuration.schedule_expression);
    try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.ScheduleConfiguration.StartTimeOffset=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.scheduled_query_configuration.schedule_configuration.start_time_offset}) catch "");
    try body_buf.appendSlice(allocator, "&ScheduledQueryConfiguration.ScheduledQueryRoleARN=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.scheduled_query_configuration.scheduled_query_role_arn);
    if (input.scheduled_query_configuration.tags) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledQueryConfiguration.Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledQueryConfiguration.Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
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
    try body_buf.appendSlice(allocator, "&Threshold=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.threshold}) catch "");
    if (input.treat_missing_data) |v| {
        try body_buf.appendSlice(allocator, "&TreatMissingData=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.warm_up_configuration) |v| {
        if (v.only_start_evaluating_after_warm_up_period_ends) |sv| {
            try body_buf.appendSlice(allocator, "&WarmUpConfiguration.OnlyStartEvaluatingAfterWarmUpPeriodEnds=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        try body_buf.appendSlice(allocator, "&WarmUpConfiguration.WarmUpPeriodDurationInMinutes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v.warm_up_period_duration_in_minutes}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutLogAlarmOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutLogAlarmOutput = .{};

    return result;
}
