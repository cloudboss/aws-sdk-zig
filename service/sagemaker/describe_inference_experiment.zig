const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    type: InferenceExperimentType,

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
        .type = "Type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceExperimentInput, options: Options) !DescribeInferenceExperimentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeInferenceExperiment");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeInferenceExperimentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInferenceExperimentOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
