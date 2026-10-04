const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeSeriesReplacementsDataSource = @import("time_series_replacements_data_source.zig").TimeSeriesReplacementsDataSource;
const TimeSeriesTransformation = @import("time_series_transformation.zig").TimeSeriesTransformation;

pub const DescribeWhatIfForecastInput = struct {
    /// The Amazon Resource Name (ARN) of the what-if forecast that you are
    /// interested in.
    what_if_forecast_arn: []const u8,

    pub const json_field_names = .{
        .what_if_forecast_arn = "WhatIfForecastArn",
    };
};

pub const DescribeWhatIfForecastOutput = struct {
    /// When the what-if forecast was created.
    creation_time: ?i64 = null,

    /// The approximate time remaining to complete the what-if forecast, in minutes.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// The quantiles at which probabilistic forecasts are generated. You can
    /// specify up to five quantiles per what-if
    /// forecast in the CreateWhatIfForecast operation. If you didn't specify
    /// quantiles, the default
    /// values are `["0.1", "0.5", "0.9"]`.
    forecast_types: ?[]const []const u8 = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The status of the what-if forecast. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// The `Status` of the what-if forecast must be `ACTIVE` before you can access
    /// the
    /// forecast.
    status: ?[]const u8 = null,

    /// An array of `S3Config`, `Schema`, and `Format` elements that describe the
    /// replacement time series.
    time_series_replacements_data_source: ?TimeSeriesReplacementsDataSource = null,

    /// An array of `Action` and `TimeSeriesConditions` elements that describe what
    /// transformations were applied to which time series.
    time_series_transformations: ?[]const TimeSeriesTransformation = null,

    /// The Amazon Resource Name (ARN) of the what-if analysis that contains this
    /// forecast.
    what_if_analysis_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the what-if forecast.
    what_if_forecast_arn: ?[]const u8 = null,

    /// The name of the what-if forecast.
    what_if_forecast_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .forecast_types = "ForecastTypes",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .time_series_replacements_data_source = "TimeSeriesReplacementsDataSource",
        .time_series_transformations = "TimeSeriesTransformations",
        .what_if_analysis_arn = "WhatIfAnalysisArn",
        .what_if_forecast_arn = "WhatIfForecastArn",
        .what_if_forecast_name = "WhatIfForecastName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWhatIfForecastInput, options: CallOptions) !DescribeWhatIfForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "forecast", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWhatIfForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeWhatIfForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWhatIfForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWhatIfForecastOutput, body, allocator);
}
