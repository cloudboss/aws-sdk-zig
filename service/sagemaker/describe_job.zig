const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobCategory = @import("job_category.zig").JobCategory;
const JobStatus = @import("job_status.zig").JobStatus;
const JobSecondaryStatus = @import("job_secondary_status.zig").JobSecondaryStatus;
const JobSecondaryStatusTransition = @import("job_secondary_status_transition.zig").JobSecondaryStatusTransition;
const Tag = @import("tag.zig").Tag;

pub const DescribeJobInput = struct {
    /// The category of the job.
    job_category: JobCategory,

    /// The name of the job to describe.
    job_name: []const u8,

    pub const json_field_names = .{
        .job_category = "JobCategory",
        .job_name = "JobName",
    };
};

pub const DescribeJobOutput = struct {
    /// The date and time that the job was created.
    creation_time: i64,

    /// The date and time that the job ended.
    end_time: ?i64 = null,

    /// If the job failed, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// The category of the job.
    job_category: JobCategory,

    /// The JSON configuration document for the job.
    job_config_document: ?[]const u8 = null,

    /// The schema version used for the job configuration document.
    job_config_schema_version: []const u8,

    /// The name of the job.
    job_name: []const u8,

    /// The current status of the job.
    job_status: JobStatus,

    /// The date and time that the job was last modified.
    last_modified_time: i64,

    /// The ARN of the IAM role associated with the job.
    role_arn: []const u8,

    /// The detailed secondary status of the job, providing more granular
    /// information about the job's progress. Secondary statuses may change between
    /// releases.
    secondary_status: JobSecondaryStatus,

    /// A list of secondary status transitions for the job, with timestamps and
    /// optional status messages.
    secondary_status_transitions: ?[]const JobSecondaryStatusTransition = null,

    /// The tags associated with the job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .job_arn = "JobArn",
        .job_category = "JobCategory",
        .job_config_document = "JobConfigDocument",
        .job_config_schema_version = "JobConfigSchemaVersion",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .last_modified_time = "LastModifiedTime",
        .role_arn = "RoleArn",
        .secondary_status = "SecondaryStatus",
        .secondary_status_transitions = "SecondaryStatusTransitions",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobInput, options: CallOptions) !DescribeJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeJobOutput, body, allocator);
}
