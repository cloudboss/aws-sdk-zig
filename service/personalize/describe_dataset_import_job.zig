const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetImportJob = @import("dataset_import_job.zig").DatasetImportJob;

pub const DescribeDatasetImportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset import job to
    /// describe.
    dataset_import_job_arn: []const u8,

    pub const json_field_names = .{
        .dataset_import_job_arn = "datasetImportJobArn",
    };
};

pub const DescribeDatasetImportJobOutput = struct {
    /// Information about the dataset import job, including the status.
    ///
    /// The status is one of the following values:
    ///
    /// * CREATE PENDING
    ///
    /// * CREATE IN_PROGRESS
    ///
    /// * ACTIVE
    ///
    /// * CREATE FAILED
    dataset_import_job: ?DatasetImportJob = null,

    pub const json_field_names = .{
        .dataset_import_job = "datasetImportJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetImportJobInput, options: CallOptions) !DescribeDatasetImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetImportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.DescribeDatasetImportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetImportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDatasetImportJobOutput, body, allocator);
}
