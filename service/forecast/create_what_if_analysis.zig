const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TimeSeriesSelector = @import("time_series_selector.zig").TimeSeriesSelector;

pub const CreateWhatIfAnalysisInput = struct {
    /// The Amazon Resource Name (ARN) of the baseline forecast.
    forecast_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/forecast/latest/dg/tagging-forecast-resources.html) to apply to the what if forecast.
    tags: ?[]const Tag = null,

    /// Defines the set of time series that are used in the what-if analysis with a
    /// `TimeSeriesIdentifiers`
    /// object. What-if analyses are performed only for the time series in this
    /// object.
    ///
    /// The `TimeSeriesIdentifiers` object needs the following information:
    ///
    /// * `DataSource`
    ///
    /// * `Format`
    ///
    /// * `Schema`
    time_series_selector: ?TimeSeriesSelector = null,

    /// The name of the what-if analysis. Each name must be unique.
    what_if_analysis_name: []const u8,

    pub const json_field_names = .{
        .forecast_arn = "ForecastArn",
        .tags = "Tags",
        .time_series_selector = "TimeSeriesSelector",
        .what_if_analysis_name = "WhatIfAnalysisName",
    };
};

pub const CreateWhatIfAnalysisOutput = struct {
    /// The Amazon Resource Name (ARN) of the what-if analysis.
    what_if_analysis_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .what_if_analysis_arn = "WhatIfAnalysisArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatIfAnalysisInput, options: CallOptions) !CreateWhatIfAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatIfAnalysisInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateWhatIfAnalysis");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatIfAnalysisOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWhatIfAnalysisOutput, body, allocator);
}
