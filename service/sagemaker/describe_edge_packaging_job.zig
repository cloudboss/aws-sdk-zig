const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgePackagingJobStatus = @import("edge_packaging_job_status.zig").EdgePackagingJobStatus;
const EdgeOutputConfig = @import("edge_output_config.zig").EdgeOutputConfig;
const EdgePresetDeploymentOutput = @import("edge_preset_deployment_output.zig").EdgePresetDeploymentOutput;

pub const DescribeEdgePackagingJobInput = struct {
    /// The name of the edge packaging job.
    edge_packaging_job_name: []const u8,

    pub const json_field_names = .{
        .edge_packaging_job_name = "EdgePackagingJobName",
    };
};

pub const DescribeEdgePackagingJobOutput = struct {
    /// The name of the SageMaker Neo compilation job that is used to locate model
    /// artifacts that are being packaged.
    compilation_job_name: ?[]const u8 = null,

    /// The timestamp of when the packaging job was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the edge packaging job.
    edge_packaging_job_arn: []const u8,

    /// The name of the edge packaging job.
    edge_packaging_job_name: []const u8,

    /// The current status of the packaging job.
    edge_packaging_job_status: EdgePackagingJobStatus,

    /// Returns a message describing the job status and error messages.
    edge_packaging_job_status_message: ?[]const u8 = null,

    /// The timestamp of when the job was last updated.
    last_modified_time: ?i64 = null,

    /// The Amazon Simple Storage (S3) URI where model artifacts ares stored.
    model_artifact: ?[]const u8 = null,

    /// The name of the model.
    model_name: ?[]const u8 = null,

    /// The signature document of files in the model artifact.
    model_signature: ?[]const u8 = null,

    /// The version of the model.
    model_version: ?[]const u8 = null,

    /// The output configuration for the edge packaging job.
    output_config: ?EdgeOutputConfig = null,

    /// The output of a SageMaker Edge Manager deployable resource.
    preset_deployment_output: ?EdgePresetDeploymentOutput = null,

    /// The Amazon Web Services KMS key to use when encrypting the EBS volume the
    /// job run on.
    resource_key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// to download and upload the model, and to contact Neo.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
        .creation_time = "CreationTime",
        .edge_packaging_job_arn = "EdgePackagingJobArn",
        .edge_packaging_job_name = "EdgePackagingJobName",
        .edge_packaging_job_status = "EdgePackagingJobStatus",
        .edge_packaging_job_status_message = "EdgePackagingJobStatusMessage",
        .last_modified_time = "LastModifiedTime",
        .model_artifact = "ModelArtifact",
        .model_name = "ModelName",
        .model_signature = "ModelSignature",
        .model_version = "ModelVersion",
        .output_config = "OutputConfig",
        .preset_deployment_output = "PresetDeploymentOutput",
        .resource_key = "ResourceKey",
        .role_arn = "RoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEdgePackagingJobInput, options: CallOptions) !DescribeEdgePackagingJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEdgePackagingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeEdgePackagingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEdgePackagingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEdgePackagingJobOutput, body, allocator);
}
