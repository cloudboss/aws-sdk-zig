const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortTrackingServerBy = @import("sort_tracking_server_by.zig").SortTrackingServerBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrackingServerStatus = @import("tracking_server_status.zig").TrackingServerStatus;
const TrackingServerSummary = @import("tracking_server_summary.zig").TrackingServerSummary;

pub const ListMlflowTrackingServersInput = struct {
    /// Use the `CreatedAfter` filter to only list tracking servers created after a
    /// specific date and time. Listed tracking servers are shown with a date and
    /// time such as `"2024-03-16T01:46:56+00:00"`. The `CreatedAfter` parameter
    /// takes in a Unix timestamp. To convert a date and time into a Unix timestamp,
    /// see [EpochConverter](https://www.epochconverter.com/).
    created_after: ?i64 = null,

    /// Use the `CreatedBefore` filter to only list tracking servers created before
    /// a specific date and time. Listed tracking servers are shown with a date and
    /// time such as `"2024-03-16T01:46:56+00:00"`. The `CreatedBefore` parameter
    /// takes in a Unix timestamp. To convert a date and time into a Unix timestamp,
    /// see [EpochConverter](https://www.epochconverter.com/).
    created_before: ?i64 = null,

    /// The maximum number of tracking servers to list.
    max_results: ?i32 = null,

    /// Filter for tracking servers using the specified MLflow version.
    mlflow_version: ?[]const u8 = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Filter for trackings servers sorting by name, creation time, or creation
    /// status.
    sort_by: ?SortTrackingServerBy = null,

    /// Change the order of the listed tracking servers. By default, tracking
    /// servers are listed in `Descending` order by creation time. To change the
    /// list order, you can specify `SortOrder` to be `Ascending`.
    sort_order: ?SortOrder = null,

    /// Filter for tracking servers with a specified creation status.
    tracking_server_status: ?TrackingServerStatus = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .mlflow_version = "MlflowVersion",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .tracking_server_status = "TrackingServerStatus",
    };
};

pub const ListMlflowTrackingServersOutput = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of tracking servers according to chosen filters.
    tracking_server_summaries: ?[]const TrackingServerSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tracking_server_summaries = "TrackingServerSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMlflowTrackingServersInput, options: CallOptions) !ListMlflowTrackingServersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMlflowTrackingServersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMlflowTrackingServers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMlflowTrackingServersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMlflowTrackingServersOutput, body, allocator);
}
