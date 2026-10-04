const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DatasetImportJobSummary = @import("dataset_import_job_summary.zig").DatasetImportJobSummary;

pub const ListDatasetImportJobsInput = struct {
    /// An array of filters. For each filter, you provide a condition and a match
    /// statement. The
    /// condition is either `IS` or `IS_NOT`, which specifies whether to include
    /// or exclude the datasets that match the statement from the list,
    /// respectively. The match
    /// statement consists of a key and a value.
    ///
    /// **Filter properties**
    ///
    /// * `Condition` - The condition to apply. Valid values are `IS` and
    /// `IS_NOT`. To include the datasets that match the statement, specify
    /// `IS`. To exclude matching datasets, specify `IS_NOT`.
    ///
    /// * `Key` - The name of the parameter to filter on. Valid values are
    /// `DatasetArn` and `Status`.
    ///
    /// * `Value` - The value to match.
    ///
    /// For example, to list all dataset import jobs whose status is ACTIVE, you
    /// specify the
    /// following filter:
    ///
    /// `"Filters": [ { "Condition": "IS", "Key": "Status", "Value": "ACTIVE" } ]`
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

pub const ListDatasetImportJobsOutput = struct {
    /// An array of objects that summarize each dataset import job's properties.
    dataset_import_jobs: ?[]const DatasetImportJobSummary = null,

    /// If the response is truncated, Amazon Forecast returns this token. To
    /// retrieve the next set of
    /// results, use the token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_import_jobs = "DatasetImportJobs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetImportJobsInput, options: CallOptions) !ListDatasetImportJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetImportJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.ListDatasetImportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetImportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDatasetImportJobsOutput, body, allocator);
}
