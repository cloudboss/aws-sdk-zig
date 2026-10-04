const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchInferenceJobSummary = @import("batch_inference_job_summary.zig").BatchInferenceJobSummary;

pub const ListBatchInferenceJobsInput = struct {
    /// The maximum number of batch inference job results to return in each page.
    /// The default
    /// value is 100.
    max_results: ?i32 = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the solution version from which the batch
    /// inference jobs
    /// were created.
    solution_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .solution_version_arn = "solutionVersionArn",
    };
};

pub const ListBatchInferenceJobsOutput = struct {
    /// A list containing information on each job that is returned.
    batch_inference_jobs: ?[]const BatchInferenceJobSummary = null,

    /// The token to use to retrieve the next page of results. The value is `null`
    /// when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_inference_jobs = "batchInferenceJobs",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBatchInferenceJobsInput, options: CallOptions) !ListBatchInferenceJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBatchInferenceJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.ListBatchInferenceJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBatchInferenceJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBatchInferenceJobsOutput, body, allocator);
}
