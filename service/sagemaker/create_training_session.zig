const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoraConfig = @import("lora_config.zig").LoraConfig;
const TrainingSessionModelConfig = @import("training_session_model_config.zig").TrainingSessionModelConfig;
const TrainingSessionOutputConfig = @import("training_session_output_config.zig").TrainingSessionOutputConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateTrainingSessionInput = struct {
    /// The Low-Rank Adaptation (LoRA) configuration for the training session,
    /// including the rank and alpha parameters.
    lora_config: LoraConfig,

    /// The configuration for the base model, including the model ARN and end-user
    /// license agreement (EULA) acceptance.
    model_config: TrainingSessionModelConfig,

    /// The Amazon Resource Name (ARN) of the model package group where checkpoints
    /// and fine-tuned model artifacts are published.
    model_package_group_arn: ?[]const u8 = null,

    /// The output configuration for the training session, including the S3 location
    /// and optional encryption settings.
    output_config: TrainingSessionOutputConfig,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon SageMaker assumes
    /// to access resources on your behalf. The role must have permissions to access
    /// the output S3 path and model package group.
    role_arn: []const u8,

    /// An array of key-value pairs to apply to the training session as tags. For
    /// more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    /// The name of the training session.
    training_session_name: []const u8,

    /// The Virtual Private Cloud (VPC) configuration for the training session.
    /// Specify subnets and security groups to run the training session in your VPC.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .lora_config = "LoraConfig",
        .model_config = "ModelConfig",
        .model_package_group_arn = "ModelPackageGroupArn",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .training_session_name = "TrainingSessionName",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateTrainingSessionOutput = struct {
    /// The Amazon Resource Name (ARN) of the training session.
    training_session_arn: []const u8,

    pub const json_field_names = .{
        .training_session_arn = "TrainingSessionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrainingSessionInput, options: CallOptions) !CreateTrainingSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrainingSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrainingSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrainingSessionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTrainingSessionOutput, body, allocator);
}
