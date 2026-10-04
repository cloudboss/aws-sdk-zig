const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitoringAlertHistorySortKey = @import("monitoring_alert_history_sort_key.zig").MonitoringAlertHistorySortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const MonitoringAlertStatus = @import("monitoring_alert_status.zig").MonitoringAlertStatus;
const MonitoringAlertHistorySummary = @import("monitoring_alert_history_summary.zig").MonitoringAlertHistorySummary;

pub const ListMonitoringAlertHistoryInput = struct {
    /// A filter that returns only alerts created on or after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only alerts created on or before the specified time.
    creation_time_before: ?i64 = null,

    /// The maximum number of results to display. The default is 100.
    max_results: ?i32 = null,

    /// The name of a monitoring alert.
    monitoring_alert_name: ?[]const u8 = null,

    /// The name of a monitoring schedule.
    monitoring_schedule_name: ?[]const u8 = null,

    /// If the result of the previous `ListMonitoringAlertHistory` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// alerts in the history, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field used to sort results. The default is `CreationTime`.
    sort_by: ?MonitoringAlertHistorySortKey = null,

    /// The sort order, whether `Ascending` or `Descending`, of the alert history.
    /// The default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only alerts with a specific status.
    status_equals: ?MonitoringAlertStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .monitoring_alert_name = "MonitoringAlertName",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListMonitoringAlertHistoryOutput = struct {
    /// An alert history for a model monitoring schedule.
    monitoring_alert_history: ?[]const MonitoringAlertHistorySummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of alerts, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitoring_alert_history = "MonitoringAlertHistory",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringAlertHistoryInput, options: CallOptions) !ListMonitoringAlertHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitoringAlertHistoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMonitoringAlertHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitoringAlertHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMonitoringAlertHistoryOutput, body, allocator);
}
