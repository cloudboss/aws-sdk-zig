const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeSeriesSelector = @import("time_series_selector.zig").TimeSeriesSelector;

pub const DescribeWhatIfAnalysisInput = struct {
    /// The Amazon Resource Name (ARN) of the what-if analysis that you are
    /// interested in.
    what_if_analysis_arn: []const u8,

    pub const json_field_names = .{
        .what_if_analysis_arn = "WhatIfAnalysisArn",
    };
};

pub const DescribeWhatIfAnalysisOutput = struct {
    /// When the what-if analysis was created.
    creation_time: ?i64 = null,

    /// The approximate time remaining to complete the what-if analysis, in minutes.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the what-if forecast.
    forecast_arn: ?[]const u8 = null,

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

    /// The status of the what-if analysis. States include:
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
    /// The `Status` of the what-if analysis must be `ACTIVE` before you can access
    /// the
    /// analysis.
    status: ?[]const u8 = null,

    time_series_selector: ?TimeSeriesSelector = null,

    /// The Amazon Resource Name (ARN) of the what-if analysis.
    what_if_analysis_arn: ?[]const u8 = null,

    /// The name of the what-if analysis.
    what_if_analysis_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .forecast_arn = "ForecastArn",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .time_series_selector = "TimeSeriesSelector",
        .what_if_analysis_arn = "WhatIfAnalysisArn",
        .what_if_analysis_name = "WhatIfAnalysisName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWhatIfAnalysisInput, options: CallOptions) !DescribeWhatIfAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWhatIfAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeWhatIfAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWhatIfAnalysisOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWhatIfAnalysisOutput, body, allocator);
}
