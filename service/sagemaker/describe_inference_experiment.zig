const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceExperimentDataStorageConfig = @import("inference_experiment_data_storage_config.zig").InferenceExperimentDataStorageConfig;
const EndpointMetadata = @import("endpoint_metadata.zig").EndpointMetadata;
const ModelVariantConfigSummary = @import("model_variant_config_summary.zig").ModelVariantConfigSummary;
const InferenceExperimentSchedule = @import("inference_experiment_schedule.zig").InferenceExperimentSchedule;
const ShadowModeConfig = @import("shadow_mode_config.zig").ShadowModeConfig;
const InferenceExperimentStatus = @import("inference_experiment_status.zig").InferenceExperimentStatus;
const InferenceExperimentType = @import("inference_experiment_type.zig").InferenceExperimentType;

pub const DescribeInferenceExperimentInput = struct {
    /// The name of the inference experiment to describe.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeInferenceExperimentOutput = struct {
    /// The ARN of the inference experiment being described.
    arn: []const u8,

    /// The timestamp at which the inference experiment was completed.
    completion_time: ?i64 = null,

    /// The timestamp at which you created the inference experiment.
    creation_time: ?i64 = null,

    /// The Amazon S3 location and configuration for storing inference request and
    /// response data.
    data_storage_config: ?InferenceExperimentDataStorageConfig = null,

    /// The description of the inference experiment.
    description: ?[]const u8 = null,

    /// The metadata of the endpoint on which the inference experiment ran.
    endpoint_metadata: ?EndpointMetadata = null,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data on the storage volume attached to
    /// the ML compute instance that hosts the endpoint. For more information, see
    /// [CreateInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceExperiment.html).
    kms_key: ?[]const u8 = null,

    /// The timestamp at which you last modified the inference experiment.
    last_modified_time: ?i64 = null,

    /// An array of `ModelVariantConfigSummary` objects. There is one for each
    /// variant in the inference experiment. Each `ModelVariantConfigSummary` object
    /// in the array describes the infrastructure configuration for deploying the
    /// corresponding variant.
    model_variants: ?[]const ModelVariantConfigSummary = null,

    /// The name of the inference experiment.
    name: []const u8,

    /// The ARN of the IAM role that Amazon SageMaker can assume to access model
    /// artifacts and container images, and manage Amazon SageMaker Inference
    /// endpoints for model deployment.
    role_arn: ?[]const u8 = null,

    /// The duration for which the inference experiment ran or will run.
    schedule: ?InferenceExperimentSchedule = null,

    /// The configuration of `ShadowMode` inference experiment type, which shows the
    /// production variant that takes all the inference requests, and the shadow
    /// variant to which Amazon SageMaker replicates a percentage of the inference
    /// requests. For the shadow variant it also shows the percentage of requests
    /// that Amazon SageMaker replicates.
    shadow_mode_config: ?ShadowModeConfig = null,

    /// The status of the inference experiment. The following are the possible
    /// statuses for an inference experiment:
    ///
    /// * `Creating` - Amazon SageMaker is creating your experiment.
    /// * `Created` - Amazon SageMaker has finished the creation of your experiment
    ///   and will begin the experiment at the scheduled time.
    /// * `Updating` - When you make changes to your experiment, your experiment
    ///   shows as updating.
    /// * `Starting` - Amazon SageMaker is beginning your experiment.
    /// * `Running` - Your experiment is in progress.
    /// * `Stopping` - Amazon SageMaker is stopping your experiment.
    /// * `Completed` - Your experiment has completed.
    /// * `Cancelled` - When you conclude your experiment early using the
    ///   [StopInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StopInferenceExperiment.html) API, or if any operation fails with an unexpected error, it shows as cancelled.
    status: InferenceExperimentStatus,

    /// The error message or client-specified `Reason` from the
    /// [StopInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StopInferenceExperiment.html) API, that explains the status of the inference experiment.
    status_reason: ?[]const u8 = null,

    /// The type of the inference experiment.
    @"type": InferenceExperimentType,

    pub const json_field_names = .{
        .arn = "Arn",
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .data_storage_config = "DataStorageConfig",
        .description = "Description",
        .endpoint_metadata = "EndpointMetadata",
        .kms_key = "KmsKey",
        .last_modified_time = "LastModifiedTime",
        .model_variants = "ModelVariants",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .shadow_mode_config = "ShadowModeConfig",
        .status = "Status",
        .status_reason = "StatusReason",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceExperimentInput, options: CallOptions) !DescribeInferenceExperimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeInferenceExperiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInferenceExperimentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeInferenceExperimentOutput, body, allocator);
}
