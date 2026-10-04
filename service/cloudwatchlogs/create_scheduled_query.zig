const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;

pub const CreateScheduledQueryInput = struct {
    /// An optional description for the scheduled query to help identify its purpose
    /// and
    /// functionality.
    description: ?[]const u8 = null,

    /// Configuration for where to deliver query results. Currently supports Amazon
    /// S3 destinations for
    /// storing query output.
    destination_configuration: ?DestinationConfiguration = null,

    /// The ARN of the IAM role that grants permissions to execute the query and
    /// deliver results
    /// to the specified destination. The role must have permissions to read from
    /// the specified log
    /// groups and write to the destination.
    execution_role_arn: []const u8,

    /// An array of log group names or ARNs to query. You can specify between 1 and
    /// 50 log groups.
    /// Log groups can be identified by name or full ARN.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The name of the scheduled query. The name must be unique within your account
    /// and region.
    /// Valid characters are alphanumeric characters, hyphens, underscores, and
    /// periods. Length must
    /// be between 1 and 255 characters.
    name: []const u8,

    /// The query language to use for the scheduled query. Valid values are `CWLI`,
    /// `PPL`, and `SQL`.
    query_language: QueryLanguage,

    /// The query string to execute. This is the same query syntax used in
    /// CloudWatch Logs
    /// Insights. Maximum length is 10,000 characters.
    query_string: []const u8,

    /// The end time for the scheduled query in Unix epoch format. The query will
    /// stop executing
    /// after this time.
    schedule_end_time: ?i64 = null,

    /// A cron expression that defines when the scheduled query runs. The expression
    /// uses standard
    /// cron syntax and supports minute-level precision. Maximum length is 256
    /// characters.
    schedule_expression: []const u8,

    /// The start time for the scheduled query in Unix epoch format. The query will
    /// not execute
    /// before this time.
    schedule_start_time: ?i64 = null,

    /// The time offset in seconds that defines the lookback period for the query.
    /// This determines
    /// how far back in time the query searches from the execution time.
    start_time_offset: ?i64 = null,

    /// The initial state of the scheduled query. Valid values are `ENABLED` and
    /// `DISABLED`. Default is `ENABLED`.
    state: ?ScheduledQueryState = null,

    /// Key-value pairs to associate with the scheduled query for resource
    /// management and cost
    /// allocation.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timezone for evaluating the schedule expression. This determines when
    /// the scheduled
    /// query executes relative to the specified timezone.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .destination_configuration = "destinationConfiguration",
        .execution_role_arn = "executionRoleArn",
        .log_group_identifiers = "logGroupIdentifiers",
        .name = "name",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_start_time = "scheduleStartTime",
        .start_time_offset = "startTimeOffset",
        .state = "state",
        .tags = "tags",
        .timezone = "timezone",
    };
};

pub const CreateScheduledQueryOutput = struct {
    /// The ARN of the created scheduled query.
    scheduled_query_arn: ?[]const u8 = null,

    /// The current state of the scheduled query.
    state: ?ScheduledQueryState = null,

    pub const json_field_names = .{
        .scheduled_query_arn = "scheduledQueryArn",
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledQueryInput, options: CallOptions) !CreateScheduledQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledQueryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateScheduledQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduledQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateScheduledQueryOutput, body, allocator);
}
