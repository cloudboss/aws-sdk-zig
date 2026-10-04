const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightsMetricDataType = @import("insights_metric_data_type.zig").InsightsMetricDataType;
const InsightType = @import("insight_type.zig").InsightType;

pub const ListInsightsMetricDataInput = struct {
    /// Type of data points to return. Valid values are `NonZeroData` and
    /// `FillWithZeros`. The default is `NonZeroData`.
    data_type: ?InsightsMetricDataType = null,

    /// Specifies, in UTC, the end time for time-series data. The value specified is
    /// exclusive;
    /// results include data points up to the specified time stamp.
    ///
    /// The default is the time of request.
    end_time: ?i64 = null,

    /// Conditionally required if the `InsightType` parameter is set to
    /// `ApiErrorRateInsight`.
    ///
    /// If returning metrics for the `ApiErrorRateInsight` Insights type, this is
    /// the error to retrieve data for. For example, `AccessDenied`.
    error_code: ?[]const u8 = null,

    /// The name of the event, typically the Amazon Web Services API on which
    /// unusual levels of activity were recorded.
    event_name: []const u8,

    /// The Amazon Web Services service to which the request was made, such as
    /// `iam.amazonaws.com` or `s3.amazonaws.com`.
    event_source: []const u8,

    /// The type of CloudTrail Insights event, which is either `ApiCallRateInsight`
    /// or `ApiErrorRateInsight`.
    /// The `ApiCallRateInsight` Insights type analyzes write-only management API
    /// calls that are aggregated per minute against a baseline API call volume.
    /// The `ApiErrorRateInsight` Insights type analyzes management API calls that
    /// result in error codes.
    insight_type: InsightType,

    /// The maximum number of data points to return. Valid values are integers from
    /// 1 to 21600.
    /// The default value is 21600.
    max_results: ?i32 = null,

    /// Returned if all datapoints can't be returned in a single call. For example,
    /// due to reaching `MaxResults`.
    ///
    /// Add this parameter to the request to continue retrieving results starting
    /// from the last evaluated point.
    next_token: ?[]const u8 = null,

    /// Granularity of data to retrieve, in seconds. Valid values are `60`, `300`,
    /// and `3600`.
    /// If you specify any other value, you will get an error. The default is 3600
    /// seconds.
    period: ?i32 = null,

    /// Specifies, in UTC, the start time for time-series data. The value specified
    /// is inclusive; results include data points with the specified time stamp.
    ///
    /// The default is 90 days before the time of request.
    start_time: ?i64 = null,

    /// The Amazon Resource Name(ARN) or name of the trail for which you want to
    /// retrieve Insights metrics data.
    /// This parameter should only be provided to fetch Insights metrics data
    /// generated on trails logging data events.
    /// This parameter is not required for Insights metric data generated on trails
    /// logging management events.
    trail_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_type = "DataType",
        .end_time = "EndTime",
        .error_code = "ErrorCode",
        .event_name = "EventName",
        .event_source = "EventSource",
        .insight_type = "InsightType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .period = "Period",
        .start_time = "StartTime",
        .trail_name = "TrailName",
    };
};

pub const ListInsightsMetricDataOutput = struct {
    /// Only returned if `InsightType` parameter was set to `ApiErrorRateInsight`.
    ///
    /// If returning metrics for the `ApiErrorRateInsight` Insights type, this is
    /// the error to retrieve data for. For example, `AccessDenied`.
    error_code: ?[]const u8 = null,

    /// The name of the event, typically the Amazon Web Services API on which
    /// unusual levels of activity were recorded.
    event_name: ?[]const u8 = null,

    /// The Amazon Web Services service to which the request was made, such as
    /// `iam.amazonaws.com` or `s3.amazonaws.com`.
    event_source: ?[]const u8 = null,

    /// The type of CloudTrail Insights event, which is either `ApiCallRateInsight`
    /// or `ApiErrorRateInsight`.
    /// The `ApiCallRateInsight` Insights type analyzes write-only management API
    /// calls that are aggregated per minute against a baseline API call volume.
    /// The `ApiErrorRateInsight` Insights type analyzes management API calls that
    /// result in error codes.
    insight_type: ?InsightType = null,

    /// Only returned if the full results could not be returned in a single query.
    /// You can set the `NextToken` parameter
    /// in the next request to this value to continue retrieval.
    next_token: ?[]const u8 = null,

    /// List of timestamps at intervals corresponding to the specified time period.
    timestamps: ?[]const i64 = null,

    /// Specifies the ARN of the trail. This is only returned when Insights is
    /// enabled on a trail logging data events.
    trail_arn: ?[]const u8 = null,

    /// List of values representing the API call rate or error rate at each
    /// timestamp. The number of values is equal to the number of timestamps.
    values: ?[]const f64 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .event_name = "EventName",
        .event_source = "EventSource",
        .insight_type = "InsightType",
        .next_token = "NextToken",
        .timestamps = "Timestamps",
        .trail_arn = "TrailARN",
        .values = "Values",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInsightsMetricDataInput, options: CallOptions) !ListInsightsMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInsightsMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.ListInsightsMetricData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInsightsMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInsightsMetricDataOutput, body, allocator);
}
