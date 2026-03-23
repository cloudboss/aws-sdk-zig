const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CloudWatchAlarmTemplateComparisonOperator = @import("cloud_watch_alarm_template_comparison_operator.zig").CloudWatchAlarmTemplateComparisonOperator;
const CloudWatchAlarmTemplateStatistic = @import("cloud_watch_alarm_template_statistic.zig").CloudWatchAlarmTemplateStatistic;
const CloudWatchAlarmTemplateTargetResourceType = @import("cloud_watch_alarm_template_target_resource_type.zig").CloudWatchAlarmTemplateTargetResourceType;
const CloudWatchAlarmTemplateTreatMissingData = @import("cloud_watch_alarm_template_treat_missing_data.zig").CloudWatchAlarmTemplateTreatMissingData;

pub const CreateCloudWatchAlarmTemplateInput = struct {
    comparison_operator: CloudWatchAlarmTemplateComparisonOperator,

    /// The number of datapoints within the evaluation period that must be breaching
    /// to trigger the alarm.
    datapoints_to_alarm: ?i32 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: i32,

    /// A cloudwatch alarm template group's identifier. Can be either be its id or
    /// current name.
    group_identifier: []const u8,

    /// The name of the metric associated with the alarm. Must be compatible with
    /// targetResourceType.
    metric_name: []const u8,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    /// The period, in seconds, over which the specified statistic is applied.
    period: i32,

    /// An ID that you assign to a create request. This ID ensures idempotency when
    /// creating resources.
    request_id: ?[]const u8 = null,

    statistic: CloudWatchAlarmTemplateStatistic,

    tags: ?[]const aws.map.StringMapEntry = null,

    target_resource_type: CloudWatchAlarmTemplateTargetResourceType,

    /// The threshold value to compare with the specified statistic.
    threshold: f64,

    treat_missing_data: CloudWatchAlarmTemplateTreatMissingData,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .datapoints_to_alarm = "DatapointsToAlarm",
        .description = "Description",
        .evaluation_periods = "EvaluationPeriods",
        .group_identifier = "GroupIdentifier",
        .metric_name = "MetricName",
        .name = "Name",
        .period = "Period",
        .request_id = "RequestId",
        .statistic = "Statistic",
        .tags = "Tags",
        .target_resource_type = "TargetResourceType",
        .threshold = "Threshold",
        .treat_missing_data = "TreatMissingData",
    };
};

pub const CreateCloudWatchAlarmTemplateOutput = struct {
    /// A cloudwatch alarm template's ARN (Amazon Resource Name)
    arn: ?[]const u8 = null,

    comparison_operator: ?CloudWatchAlarmTemplateComparisonOperator = null,

    created_at: ?i64 = null,

    /// The number of datapoints within the evaluation period that must be breaching
    /// to trigger the alarm.
    datapoints_to_alarm: ?i32 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: ?i32 = null,

    /// A cloudwatch alarm template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    group_id: ?[]const u8 = null,

    /// A cloudwatch alarm template's id. AWS provided templates have ids that start
    /// with `aws-`
    id: ?[]const u8 = null,

    /// The name of the metric associated with the alarm. Must be compatible with
    /// targetResourceType.
    metric_name: ?[]const u8 = null,

    modified_at: ?i64 = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: ?[]const u8 = null,

    /// The period, in seconds, over which the specified statistic is applied.
    period: ?i32 = null,

    statistic: ?CloudWatchAlarmTemplateStatistic = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    target_resource_type: ?CloudWatchAlarmTemplateTargetResourceType = null,

    /// The threshold value to compare with the specified statistic.
    threshold: ?f64 = null,

    treat_missing_data: ?CloudWatchAlarmTemplateTreatMissingData = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .comparison_operator = "ComparisonOperator",
        .created_at = "CreatedAt",
        .datapoints_to_alarm = "DatapointsToAlarm",
        .description = "Description",
        .evaluation_periods = "EvaluationPeriods",
        .group_id = "GroupId",
        .id = "Id",
        .metric_name = "MetricName",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .period = "Period",
        .statistic = "Statistic",
        .tags = "Tags",
        .target_resource_type = "TargetResourceType",
        .threshold = "Threshold",
        .treat_missing_data = "TreatMissingData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudWatchAlarmTemplateInput, options: CallOptions) !CreateCloudWatchAlarmTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCloudWatchAlarmTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/prod/cloudwatch-alarm-templates";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ComparisonOperator\":");
    try aws.json.writeValue(@TypeOf(input.comparison_operator), input.comparison_operator, allocator, &body_buf);
    has_prev = true;
    if (input.datapoints_to_alarm) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DatapointsToAlarm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EvaluationPeriods\":");
    try aws.json.writeValue(@TypeOf(input.evaluation_periods), input.evaluation_periods, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GroupIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.group_identifier), input.group_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MetricName\":");
    try aws.json.writeValue(@TypeOf(input.metric_name), input.metric_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Period\":");
    try aws.json.writeValue(@TypeOf(input.period), input.period, allocator, &body_buf);
    has_prev = true;
    if (input.request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Statistic\":");
    try aws.json.writeValue(@TypeOf(input.statistic), input.statistic, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetResourceType\":");
    try aws.json.writeValue(@TypeOf(input.target_resource_type), input.target_resource_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Threshold\":");
    try aws.json.writeValue(@TypeOf(input.threshold), input.threshold, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TreatMissingData\":");
    try aws.json.writeValue(@TypeOf(input.treat_missing_data), input.treat_missing_data, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCloudWatchAlarmTemplateOutput {
    var result: CreateCloudWatchAlarmTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCloudWatchAlarmTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
