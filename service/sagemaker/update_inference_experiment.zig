const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceExperimentDataStorageConfig = @import("inference_experiment_data_storage_config.zig").InferenceExperimentDataStorageConfig;
const ModelVariantConfig = @import("model_variant_config.zig").ModelVariantConfig;
const InferenceExperimentSchedule = @import("inference_experiment_schedule.zig").InferenceExperimentSchedule;
const ShadowModeConfig = @import("shadow_mode_config.zig").ShadowModeConfig;

pub const UpdateInferenceExperimentInput = struct {
    /// The Amazon S3 location and configuration for storing inference request and
    /// response data.
    data_storage_config: ?InferenceExperimentDataStorageConfig = null,

    /// The description of the inference experiment.
    description: ?[]const u8 = null,

    /// An array of `ModelVariantConfig` objects. There is one for each variant,
    /// whose infrastructure configuration you want to update.
    model_variants: ?[]const ModelVariantConfig = null,

    /// The name of the inference experiment to be updated.
    name: []const u8,

    /// The duration for which the inference experiment will run. If the status of
    /// the inference experiment is `Created`, then you can update both the start
    /// and end dates. If the status of the inference experiment is `Running`, then
    /// you can update only the end date.
    schedule: ?InferenceExperimentSchedule = null,

    /// The configuration of `ShadowMode` inference experiment type. Use this field
    /// to specify a production variant which takes all the inference requests, and
    /// a shadow variant to which Amazon SageMaker replicates a percentage of the
    /// inference requests. For the shadow variant also specify the percentage of
    /// requests that Amazon SageMaker replicates.
    shadow_mode_config: ?ShadowModeConfig = null,

    pub const json_field_names = .{
        .data_storage_config = "DataStorageConfig",
        .description = "Description",
        .model_variants = "ModelVariants",
        .name = "Name",
        .schedule = "Schedule",
        .shadow_mode_config = "ShadowModeConfig",
    };
};

pub const UpdateInferenceExperimentOutput = struct {
    /// The ARN of the updated inference experiment.
    inference_experiment_arn: []const u8,

    pub const json_field_names = .{
        .inference_experiment_arn = "InferenceExperimentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInferenceExperimentInput, options: CallOptions) !UpdateInferenceExperimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateInferenceExperiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInferenceExperimentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateInferenceExperimentOutput, body, allocator);
}
