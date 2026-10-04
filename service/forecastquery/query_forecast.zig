const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Forecast = @import("forecast.zig").Forecast;

pub const QueryForecastInput = struct {
    /// The end date for the forecast. Specify the date using this format:
    /// yyyy-MM-dd'T'HH:mm:ss
    /// (ISO 8601 format). For example, 2015-01-01T20:00:00.
    end_date: ?[]const u8 = null,

    /// The filtering criteria to apply when retrieving the forecast. For example,
    /// to get the
    /// forecast for `client_21` in the electricity usage dataset, specify the
    /// following:
    ///
    /// `{"item_id" : "client_21"}`
    ///
    /// To get the full forecast, use the
    /// [CreateForecastExportJob](https://docs.aws.amazon.com/en_us/forecast/latest/dg/API_CreateForecastExportJob.html) operation.
    filters: []const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the forecast to query.
    forecast_arn: []const u8,

    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    /// The start date for the forecast. Specify the date using this format:
    /// yyyy-MM-dd'T'HH:mm:ss
    /// (ISO 8601 format). For example, 2015-01-01T08:00:00.
    start_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .filters = "Filters",
        .forecast_arn = "ForecastArn",
        .next_token = "NextToken",
        .start_date = "StartDate",
    };
};

pub const QueryForecastOutput = struct {
    /// The forecast.
    forecast: ?Forecast = null,

    pub const json_field_names = .{
        .forecast = "Forecast",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryForecastInput, options: CallOptions) !QueryForecastOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecastquery", "forecastquery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecastRuntime.QueryForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryForecastOutput, body, allocator);
}
