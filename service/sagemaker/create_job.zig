const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobCategory = @import("job_category.zig").JobCategory;
const Tag = @import("tag.zig").Tag;

pub const CreateJobInput = struct {
    /// The category of the job. The category determines the type of workload that
    /// the job runs.
    job_category: JobCategory,

    /// The JSON configuration document for the job. The document must conform to
    /// the schema specified by `JobConfigSchemaVersion`. Use
    /// `DescribeJobSchemaVersion` to retrieve the schema for validation.
    job_config_document: []const u8,

    /// The version of the configuration schema to use for the job configuration
    /// document. Use `ListJobSchemaVersions` to get available schema versions for a
    /// job category.
    job_config_schema_version: []const u8,

    /// The name of the job. The name must be unique within your account and Amazon
    /// Web Services Region.
    job_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon SageMaker assumes
    /// to perform the job. The role must have the necessary permissions to access
    /// the resources required by the job configuration.
    role_arn: []const u8,

    /// An array of key-value pairs to apply to the job as tags. For more
    /// information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .job_category = "JobCategory",
        .job_config_document = "JobConfigDocument",
        .job_config_schema_version = "JobConfigSchemaVersion",
        .job_name = "JobName",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "JobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: CallOptions) !CreateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateJobOutput, body, allocator);
}
