const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const PredictorBacktestExportJobSummary = @import("predictor_backtest_export_job_summary.zig").PredictorBacktestExportJobSummary;

pub const ListPredictorBacktestExportJobsInput = struct {
    /// An array of filters. For each filter, provide a condition and a match
    /// statement. The
    /// condition is either `IS` or `IS_NOT`, which specifies whether to
    /// include or exclude the predictor backtest export jobs that match the
    /// statement from the
    /// list. The match statement consists of a key and a value.
    ///
    /// **Filter properties**
    ///
    /// * `Condition` - The condition to apply. Valid values are
    /// `IS` and `IS_NOT`. To include the predictor backtest
    /// export jobs that match the statement, specify `IS`. To exclude
    /// matching predictor backtest export jobs, specify `IS_NOT`.
    ///
    /// * `Key` - The name of the parameter to filter on. Valid values are
    /// `PredictorArn` and `Status`.
    ///
    /// * `Value` - The value to match.
    filters: ?[]const Filter = null,

    /// The number of items to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous request was truncated, the response includes a
    /// NextToken. To retrieve the next set of results, use the token in the next
    /// request.
    /// Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListPredictorBacktestExportJobsOutput = struct {
    /// Returns this token if the response is truncated. To retrieve the next set of
    /// results,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// An array of objects that summarize the properties of each predictor backtest
    /// export
    /// job.
    predictor_backtest_export_jobs: ?[]const PredictorBacktestExportJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .predictor_backtest_export_jobs = "PredictorBacktestExportJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPredictorBacktestExportJobsInput, options: CallOptions) !ListPredictorBacktestExportJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPredictorBacktestExportJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.ListPredictorBacktestExportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPredictorBacktestExportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPredictorBacktestExportJobsOutput, body, allocator);
}
