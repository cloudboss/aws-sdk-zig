const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudWatchAlarmTemplateComparisonOperator = @import("cloud_watch_alarm_template_comparison_operator.zig").CloudWatchAlarmTemplateComparisonOperator;
const CloudWatchAlarmTemplateStatistic = @import("cloud_watch_alarm_template_statistic.zig").CloudWatchAlarmTemplateStatistic;
const CloudWatchAlarmTemplateTargetResourceType = @import("cloud_watch_alarm_template_target_resource_type.zig").CloudWatchAlarmTemplateTargetResourceType;
const CloudWatchAlarmTemplateTreatMissingData = @import("cloud_watch_alarm_template_treat_missing_data.zig").CloudWatchAlarmTemplateTreatMissingData;

pub const GetCloudWatchAlarmTemplateInput = struct {
    /// A cloudwatch alarm template's identifier. Can be either be its id or current
    /// name.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetCloudWatchAlarmTemplateOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCloudWatchAlarmTemplateInput, options: CallOptions) !GetCloudWatchAlarmTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCloudWatchAlarmTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/cloudwatch-alarm-templates/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCloudWatchAlarmTemplateOutput {
    var result: GetCloudWatchAlarmTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCloudWatchAlarmTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
