const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeOutputConfig = @import("edge_output_config.zig").EdgeOutputConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateEdgePackagingJobInput = struct {
    /// The name of the SageMaker Neo compilation job that will be used to locate
    /// model artifacts for packaging.
    compilation_job_name: []const u8,

    /// The name of the edge packaging job.
    edge_packaging_job_name: []const u8,

    /// The name of the model.
    model_name: []const u8,

    /// The version of the model.
    model_version: []const u8,

    /// Provides information about the output location for the packaged model.
    output_config: EdgeOutputConfig,

    /// The Amazon Web Services KMS key to use when encrypting the EBS volume the
    /// edge packaging job runs on.
    resource_key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// to download and upload the model, and to contact SageMaker Neo.
    role_arn: []const u8,

    /// Creates tags for the packaging job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
        .edge_packaging_job_name = "EdgePackagingJobName",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
        .output_config = "OutputConfig",
        .resource_key = "ResourceKey",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateEdgePackagingJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEdgePackagingJobInput, options: CallOptions) !CreateEdgePackagingJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEdgePackagingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateEdgePackagingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEdgePackagingJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
