const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestionMode = @import("ingestion_mode.zig").IngestionMode;
const DatasetExportJobOutput = @import("dataset_export_job_output.zig").DatasetExportJobOutput;
const Tag = @import("tag.zig").Tag;

pub const CreateDatasetExportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset that contains the data
    /// to export.
    dataset_arn: []const u8,

    /// The data to export, based on how you imported the data. You can choose
    /// to export only `BULK` data that you imported using a dataset
    /// import job, only `PUT` data that you imported incrementally
    /// (using the console, PutEvents, PutUsers and PutItems operations), or
    /// `ALL` for both types. The default value is `PUT`.
    ingestion_mode: ?IngestionMode = null,

    /// The name for the dataset export job.
    job_name: []const u8,

    /// The path to the Amazon S3 bucket where the job's output is stored.
    job_output: DatasetExportJobOutput,

    /// The Amazon Resource Name (ARN) of the IAM service role that has
    /// permissions to add data to your output Amazon S3 bucket.
    role_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the dataset export job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .ingestion_mode = "ingestionMode",
        .job_name = "jobName",
        .job_output = "jobOutput",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateDatasetExportJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset export job.
    dataset_export_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_export_job_arn = "datasetExportJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetExportJobInput, options: CallOptions) !CreateDatasetExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetExportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateDatasetExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetExportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetExportJobOutput, body, allocator);
}
