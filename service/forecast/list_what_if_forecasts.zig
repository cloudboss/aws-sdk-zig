const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const WhatIfForecastSummary = @import("what_if_forecast_summary.zig").WhatIfForecastSummary;

pub const ListWhatIfForecastsInput = struct {
    /// An array of filters. For each filter, you provide a condition and a match
    /// statement. The condition is either
    /// `IS` or `IS_NOT`, which specifies whether to include or exclude the what-if
    /// forecast
    /// export jobs that match the statement from the list, respectively. The match
    /// statement consists of a key and a
    /// value.
    ///
    /// **Filter properties**
    ///
    /// * `Condition` - The condition to apply. Valid values are `IS` and
    /// `IS_NOT`. To include the forecast export jobs that match the statement,
    /// specify `IS`. To exclude matching forecast export jobs, specify
    /// `IS_NOT`.
    ///
    /// * `Key` - The name of the parameter to filter on. Valid values are
    /// `WhatIfForecastArn` and `Status`.
    ///
    /// * `Value` - The value to match.
    ///
    /// For example, to list all jobs that export a forecast named
    /// *electricityWhatIfForecast*, specify the following filter:
    ///
    /// `"Filters": [ { "Condition": "IS", "Key": "WhatIfForecastArn", "Value":
    /// "arn:aws:forecast:us-west-2::forecast/electricityWhatIfForecast" } ]`
    filters: ?[]const Filter = null,

    /// The number of items to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next 
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListWhatIfForecastsOutput = struct {
    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next 
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    /// An array of `WhatIfForecasts` objects that describe the matched forecasts.
    what_if_forecasts: ?[]const WhatIfForecastSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .what_if_forecasts = "WhatIfForecasts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWhatIfForecastsInput, options: CallOptions) !ListWhatIfForecastsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWhatIfForecastsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.ListWhatIfForecasts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWhatIfForecastsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListWhatIfForecastsOutput, body, allocator);
}
