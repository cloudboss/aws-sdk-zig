const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Interval = @import("interval.zig").Interval;
const MetricType = @import("metric_type.zig").MetricType;
const TimeRange = @import("time_range.zig").TimeRange;

pub const GetSnapshotsInput = struct {
    /// The identifier of the index to get search metrics data.
    index_id: []const u8,

    /// The time interval or time window to get search metrics data. The time
    /// interval uses
    /// the time zone of your index. You can view data in the following time
    /// windows:
    ///
    /// * `THIS_WEEK`: The current week, starting on the Sunday and ending on
    /// the day before the current date.
    ///
    /// * `ONE_WEEK_AGO`: The previous week, starting on the Sunday and
    /// ending on the following Saturday.
    ///
    /// * `TWO_WEEKS_AGO`: The week before the previous week, starting on the
    /// Sunday and ending on the following Saturday.
    ///
    /// * `THIS_MONTH`: The current month, starting on the first day of the
    /// month and ending on the day before the current date.
    ///
    /// * `ONE_MONTH_AGO`: The previous month, starting on the first day of
    /// the month and ending on the last day of the month.
    ///
    /// * `TWO_MONTHS_AGO`: The month before the previous month, starting on
    /// the first day of the month and ending on last day of the month.
    interval: Interval,

    /// The maximum number of returned data for the metric.
    max_results: ?i32 = null,

    /// The metric you want to retrieve. You can specify only one metric per call.
    ///
    /// For more information about the metrics you can view, see [Gaining insights
    /// with search
    /// analytics](https://docs.aws.amazon.com/kendra/latest/dg/search-analytics.html).
    metric_type: MetricType,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve),
    /// Amazon Kendra returns a pagination token in the response. You can use this
    /// pagination token to retrieve the next set of search metrics data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_id = "IndexId",
        .interval = "Interval",
        .max_results = "MaxResults",
        .metric_type = "MetricType",
        .next_token = "NextToken",
    };
};

pub const GetSnapshotsOutput = struct {
    /// If the response is truncated, Amazon Kendra returns this token, which you
    /// can use
    /// in a later request to retrieve the next set of search metrics data.
    next_token: ?[]const u8 = null,

    /// The search metrics data. The data returned depends on the metric type you
    /// requested.
    snapshots_data: ?[]const []const []const u8 = null,

    /// The column headers for the search metrics data.
    snapshots_data_header: ?[]const []const u8 = null,

    /// The Unix timestamp for the beginning and end of the time window for the
    /// search metrics data.
    snap_shot_time_filter: ?TimeRange = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .snapshots_data = "SnapshotsData",
        .snapshots_data_header = "SnapshotsDataHeader",
        .snap_shot_time_filter = "SnapShotTimeFilter",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSnapshotsInput, options: CallOptions) !GetSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.GetSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSnapshotsOutput, body, allocator);
}
