const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobFilter = @import("job_filter.zig").JobFilter;
const RecommendationExportJob = @import("recommendation_export_job.zig").RecommendationExportJob;

pub const DescribeRecommendationExportJobsInput = struct {
    /// An array of objects to specify a filter that returns a more specific list of
    /// export
    /// jobs.
    filters: ?[]const JobFilter = null,

    /// The identification numbers of the export jobs to return.
    ///
    /// An export job ID is returned when you create an export using the
    /// ExportAutoScalingGroupRecommendations or ExportEC2InstanceRecommendations
    /// actions.
    ///
    /// All export jobs created in the last seven days are returned if this
    /// parameter is
    /// omitted.
    job_ids: ?[]const []const u8 = null,

    /// The maximum number of export jobs to return with a single request.
    ///
    /// To retrieve the remaining results, make another request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The token to advance to the next page of export jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .job_ids = "jobIds",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeRecommendationExportJobsOutput = struct {
    /// The token to use to advance to the next page of export jobs.
    ///
    /// This value is null when there are no more pages of export jobs to return.
    next_token: ?[]const u8 = null,

    /// An array of objects that describe recommendation export jobs.
    recommendation_export_jobs: ?[]const RecommendationExportJob = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recommendation_export_jobs = "recommendationExportJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRecommendationExportJobsInput, options: CallOptions) !DescribeRecommendationExportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRecommendationExportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.DescribeRecommendationExportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRecommendationExportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRecommendationExportJobsOutput, body, allocator);
}
