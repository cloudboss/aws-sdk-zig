const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ScheduleType = @import("schedule_type.zig").ScheduleType;

pub const UpdateScheduledQueryInput = struct {
    /// An updated description for the scheduled query.
    description: ?[]const u8 = null,

    /// The updated configuration for where to deliver query results.
    destination_configuration: ?DestinationConfiguration = null,

    /// The updated time offset in seconds that defines the end of the lookback
    /// period for
    /// the query.
    end_time_offset: ?i64 = null,

    /// The updated ARN of the IAM role that grants permissions to execute the query
    /// and deliver
    /// results.
    execution_role_arn: []const u8,

    /// The ARN or name of the scheduled query to update.
    identifier: []const u8,

    /// The updated array of log group names or ARNs to query.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The updated query language for the scheduled query.
    query_language: QueryLanguage,

    /// The updated query string to execute.
    query_string: []const u8,

    /// The updated end time for the scheduled query in Unix epoch format.
    schedule_end_time: ?i64 = null,

    /// The updated cron expression that defines when the scheduled query runs.
    schedule_expression: []const u8,

    /// The updated start time for the scheduled query in Unix epoch format.
    schedule_start_time: ?i64 = null,

    /// The updated time offset in seconds that defines the lookback period for the
    /// query.
    start_time_offset: ?i64 = null,

    /// The updated state of the scheduled query.
    state: ?ScheduledQueryState = null,

    /// The updated timezone for evaluating the schedule expression.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .destination_configuration = "destinationConfiguration",
        .end_time_offset = "endTimeOffset",
        .execution_role_arn = "executionRoleArn",
        .identifier = "identifier",
        .log_group_identifiers = "logGroupIdentifiers",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_start_time = "scheduleStartTime",
        .start_time_offset = "startTimeOffset",
        .state = "state",
        .timezone = "timezone",
    };
};

pub const UpdateScheduledQueryOutput = struct {
    /// The timestamp when the scheduled query was originally created.
    creation_time: ?i64 = null,

    /// The description of the updated scheduled query.
    description: ?[]const u8 = null,

    /// The destination configuration of the updated scheduled query.
    destination_configuration: ?DestinationConfiguration = null,

    /// The end time offset in seconds of the updated scheduled query.
    end_time_offset: ?i64 = null,

    /// The execution role ARN of the updated scheduled query.
    execution_role_arn: ?[]const u8 = null,

    /// The status of the most recent execution of the updated scheduled query.
    last_execution_status: ?ExecutionStatus = null,

    /// The timestamp when the updated scheduled query was last executed.
    last_triggered_time: ?i64 = null,

    /// The timestamp when the scheduled query was last updated.
    last_updated_time: ?i64 = null,

    /// The log groups queried by the updated scheduled query.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The name of the updated scheduled query.
    name: ?[]const u8 = null,

    /// The query language of the updated scheduled query.
    query_language: ?QueryLanguage = null,

    /// The query string of the updated scheduled query.
    query_string: ?[]const u8 = null,

    /// The ARN of the updated scheduled query.
    scheduled_query_arn: ?[]const u8 = null,

    /// The end time of the updated scheduled query.
    schedule_end_time: ?i64 = null,

    /// The cron expression of the updated scheduled query.
    schedule_expression: ?[]const u8 = null,

    /// The start time of the updated scheduled query.
    schedule_start_time: ?i64 = null,

    /// The schedule type of the updated scheduled query.
    schedule_type: ?ScheduleType = null,

    /// The time offset of the updated scheduled query.
    start_time_offset: ?i64 = null,

    /// The state of the updated scheduled query.
    state: ?ScheduledQueryState = null,

    /// The timezone of the updated scheduled query.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .destination_configuration = "destinationConfiguration",
        .end_time_offset = "endTimeOffset",
        .execution_role_arn = "executionRoleArn",
        .last_execution_status = "lastExecutionStatus",
        .last_triggered_time = "lastTriggeredTime",
        .last_updated_time = "lastUpdatedTime",
        .log_group_identifiers = "logGroupIdentifiers",
        .name = "name",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .scheduled_query_arn = "scheduledQueryArn",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_start_time = "scheduleStartTime",
        .schedule_type = "scheduleType",
        .start_time_offset = "startTimeOffset",
        .state = "state",
        .timezone = "timezone",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledQueryInput, options: CallOptions) !UpdateScheduledQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScheduledQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateScheduledQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScheduledQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateScheduledQueryOutput, body, allocator);
}
