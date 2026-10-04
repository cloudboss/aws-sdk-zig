const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;
const PipelineDefinitionS3Location = @import("pipeline_definition_s3_location.zig").PipelineDefinitionS3Location;
const Tag = @import("tag.zig").Tag;

pub const CreatePipelineInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the operation. An idempotent operation completes no more than
    /// one time.
    client_request_token: []const u8,

    /// This is the configuration that controls the parallelism of the pipeline. If
    /// specified, it applies to all runs of this pipeline by default.
    parallelism_configuration: ?ParallelismConfiguration = null,

    /// The [JSON pipeline
    /// definition](https://aws-sagemaker-mlops.github.io/sagemaker-model-building-pipeline-definition-JSON-schema/) of the pipeline.
    pipeline_definition: ?[]const u8 = null,

    /// The location of the pipeline definition stored in Amazon S3. If specified,
    /// SageMaker will retrieve the pipeline definition from this location.
    pipeline_definition_s3_location: ?PipelineDefinitionS3Location = null,

    /// A description of the pipeline.
    pipeline_description: ?[]const u8 = null,

    /// The display name of the pipeline.
    pipeline_display_name: ?[]const u8 = null,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// The Amazon Resource Name (ARN) of the role used by the pipeline to access
    /// and create resources.
    role_arn: []const u8,

    /// A list of tags to apply to the created pipeline.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_definition = "PipelineDefinition",
        .pipeline_definition_s3_location = "PipelineDefinitionS3Location",
        .pipeline_description = "PipelineDescription",
        .pipeline_display_name = "PipelineDisplayName",
        .pipeline_name = "PipelineName",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreatePipelineOutput = struct {
    /// The Amazon Resource Name (ARN) of the created pipeline.
    pipeline_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_arn = "PipelineArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePipelineInput, options: CallOptions) !CreatePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePipelineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreatePipeline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePipelineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePipelineOutput, body, allocator);
}
