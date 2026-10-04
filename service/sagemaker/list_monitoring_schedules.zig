const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;
const MonitoringScheduleSortKey = @import("monitoring_schedule_sort_key.zig").MonitoringScheduleSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringScheduleSummary = @import("monitoring_schedule_summary.zig").MonitoringScheduleSummary;

pub const ListMonitoringSchedulesInput = struct {
    /// A filter that returns only monitoring schedules created after a specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only monitoring schedules created before a specified
    /// time.
    creation_time_before: ?i64 = null,

    /// Name of a specific endpoint to fetch schedules for.
    endpoint_name: ?[]const u8 = null,

    /// A filter that returns only monitoring schedules modified after a specified
    /// time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only monitoring schedules modified before a specified
    /// time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of jobs to return in the response. The default value is
    /// 10.
    max_results: ?i32 = null,

    /// Gets a list of the monitoring schedules for the specified monitoring job
    /// definition.
    monitoring_job_definition_name: ?[]const u8 = null,

    /// A filter that returns only the monitoring schedules for the specified
    /// monitoring type.
    monitoring_type_equals: ?MonitoringType = null,

    /// Filter for monitoring schedules whose name contains a specified string.
    name_contains: ?[]const u8 = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    /// Whether to sort the results by the `Status`, `CreationTime`, or
    /// `ScheduledTime` field. The default is `CreationTime`.
    sort_by: ?MonitoringScheduleSortKey = null,

    /// Whether to sort the results in `Ascending` or `Descending` order. The
    /// default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only monitoring schedules modified before a specified
    /// time.
    status_equals: ?ScheduleStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .endpoint_name = "EndpointName",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_type_equals = "MonitoringTypeEquals",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListMonitoringSchedulesOutput = struct {
    /// A JSON array in which each element is a summary for a monitoring schedule.
    monitoring_schedule_summaries: ?[]const MonitoringScheduleSummary = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitoring_schedule_summaries = "MonitoringScheduleSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringSchedulesInput, options: CallOptions) !ListMonitoringSchedulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitoringSchedulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMonitoringSchedules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitoringSchedulesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListMonitoringSchedulesOutput, body, allocator);
}
