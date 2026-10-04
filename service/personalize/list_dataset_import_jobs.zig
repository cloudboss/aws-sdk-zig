const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetImportJobSummary = @import("dataset_import_job_summary.zig").DatasetImportJobSummary;

pub const ListDatasetImportJobsInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset to list the dataset
    /// import jobs for.
    dataset_arn: ?[]const u8 = null,

    /// The maximum number of dataset import jobs to return.
    max_results: ?i32 = null,

    /// A token returned from the previous call to
    /// `ListDatasetImportJobs` for getting the next set of dataset
    /// import jobs (if they exist).
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDatasetImportJobsOutput = struct {
    /// The list of dataset import jobs.
    dataset_import_jobs: ?[]const DatasetImportJobSummary = null,

    /// A token for getting the next set of dataset import jobs (if they
    /// exist).
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_import_jobs = "datasetImportJobs",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetImportJobsInput, options: CallOptions) !ListDatasetImportJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetImportJobsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.ListDatasetImportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetImportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDatasetImportJobsOutput, body, allocator);
}
