const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchImport = @import("batch_import.zig").BatchImport;

pub const GetBatchImportJobsInput = struct {
    /// The ID of the batch import job to get.
    job_id: ?[]const u8 = null,

    /// The maximum number of objects to return for request.
    max_results: ?i32 = null,

    /// The next token from the previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetBatchImportJobsOutput = struct {
    /// An array containing the details of each batch import job.
    batch_imports: ?[]const BatchImport = null,

    /// The next token for the subsequent resquest.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_imports = "batchImports",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchImportJobsInput, options: CallOptions) !GetBatchImportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchImportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.GetBatchImportJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchImportJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBatchImportJobsOutput, body, allocator);
}
