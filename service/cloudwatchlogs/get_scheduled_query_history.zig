const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TriggerHistoryRecord = @import("trigger_history_record.zig").TriggerHistoryRecord;

pub const GetScheduledQueryHistoryInput = struct {
    /// The end time for the history query in Unix epoch format.
    end_time: i64,

    /// An array of execution statuses to filter the history results. Only
    /// executions with the
    /// specified statuses are returned.
    execution_statuses: ?[]const ExecutionStatus = null,

    /// The ARN or name of the scheduled query to retrieve history for.
    identifier: []const u8,

    /// The maximum number of history records to return. Valid range is 1 to 1000.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The start time for the history query in Unix epoch format.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .execution_statuses = "executionStatuses",
        .identifier = "identifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_time = "startTime",
    };
};

pub const GetScheduledQueryHistoryOutput = struct {
    /// The name of the scheduled query.
    name: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    /// The ARN of the scheduled query.
    scheduled_query_arn: ?[]const u8 = null,

    /// An array of execution history records for the scheduled query.
    trigger_history: ?[]const TriggerHistoryRecord = null,

    pub const json_field_names = .{
        .name = "name",
        .next_token = "nextToken",
        .scheduled_query_arn = "scheduledQueryArn",
        .trigger_history = "triggerHistory",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScheduledQueryHistoryInput, options: CallOptions) !GetScheduledQueryHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScheduledQueryHistoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetScheduledQueryHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScheduledQueryHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetScheduledQueryHistoryOutput, body, allocator);
}
