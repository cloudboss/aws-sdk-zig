const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeSeriesSelector = @import("time_series_selector.zig").TimeSeriesSelector;

pub const DescribeForecastInput = struct {
    /// The Amazon Resource Name (ARN) of the forecast.
    forecast_arn: []const u8,

    pub const json_field_names = .{
        .forecast_arn = "ForecastArn",
    };
};

pub const DescribeForecastOutput = struct {
    /// When the forecast creation task was created.
    creation_time: ?i64 = null,

    /// The ARN of the dataset group that provided the data used to train the
    /// predictor.
    dataset_group_arn: ?[]const u8 = null,

    /// The estimated time remaining in minutes for the forecast job to complete.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// The forecast ARN as specified in the request.
    forecast_arn: ?[]const u8 = null,

    /// The name of the forecast.
    forecast_name: ?[]const u8 = null,

    /// The quantiles at which probabilistic forecasts were generated.
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

    /// The ARN of the predictor used to generate the forecast.
    predictor_arn: ?[]const u8 = null,

    /// The status of the forecast. States include:
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
    /// The `Status` of the forecast must be `ACTIVE` before you can query
    /// or export the forecast.
    status: ?[]const u8 = null,

    /// The time series to include in the forecast.
    time_series_selector: ?TimeSeriesSelector = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_group_arn = "DatasetGroupArn",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .forecast_arn = "ForecastArn",
        .forecast_name = "ForecastName",
        .forecast_types = "ForecastTypes",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .predictor_arn = "PredictorArn",
        .status = "Status",
        .time_series_selector = "TimeSeriesSelector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeForecastInput, options: CallOptions) !DescribeForecastOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeForecastInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeForecastOutput, body, allocator);
}
