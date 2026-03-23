const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceExperimentDataStorageConfig = @import("inference_experiment_data_storage_config.zig").InferenceExperimentDataStorageConfig;
const ModelVariantConfig = @import("model_variant_config.zig").ModelVariantConfig;
const InferenceExperimentSchedule = @import("inference_experiment_schedule.zig").InferenceExperimentSchedule;
const ShadowModeConfig = @import("shadow_mode_config.zig").ShadowModeConfig;
const Tag = @import("tag.zig").Tag;
const InferenceExperimentType = @import("inference_experiment_type.zig").InferenceExperimentType;

pub const CreateInferenceExperimentInput = struct {
    /// The Amazon S3 location and configuration for storing inference request and
    /// response data.
    ///
    /// This is an optional parameter that you can use for data capture. For more
    /// information, see [Capture
    /// data](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor-data-capture.html).
    data_storage_config: ?InferenceExperimentDataStorageConfig = null,

    /// A description for the inference experiment.
    description: ?[]const u8 = null,

    /// The name of the Amazon SageMaker endpoint on which you want to run the
    /// inference experiment.
    endpoint_name: []const u8,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt data on the storage volume attached to
    /// the ML compute instance that hosts the endpoint. The `KmsKey` can be any of
    /// the following formats:
    ///
    /// * KMS key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * Amazon Resource Name (ARN) of a KMS key
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * KMS key Alias
    ///
    /// `"alias/ExampleAlias"`
    /// * Amazon Resource Name (ARN) of a KMS key Alias
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias"`
    ///
    /// If you use a KMS key ID or an alias of your KMS key, the Amazon SageMaker
    /// execution role must include permissions to call `kms:Encrypt`. If you don't
    /// provide a KMS key ID, Amazon SageMaker uses the default KMS key for Amazon
    /// S3 for your role's account. Amazon SageMaker uses server-side encryption
    /// with KMS managed keys for `OutputDataConfig`. If you use a bucket policy
    /// with an `s3:PutObject` permission that only allows objects with server-side
    /// encryption, set the condition key of `s3:x-amz-server-side-encryption` to
    /// `"aws:kms"`. For more information, see [KMS managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide.*
    ///
    /// The KMS key policy must grant permission to the IAM role that you specify in
    /// your `CreateEndpoint` and `UpdateEndpoint` requests. For more information,
    /// see [Using Key Policies in Amazon Web Services
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the *Amazon Web Services Key Management Service Developer Guide*.
    kms_key: ?[]const u8 = null,

    /// An array of `ModelVariantConfig` objects. There is one for each variant in
    /// the inference experiment. Each `ModelVariantConfig` object in the array
    /// describes the infrastructure configuration for the corresponding variant.
    model_variants: []const ModelVariantConfig,

    /// The name for the inference experiment.
    name: []const u8,

    /// The ARN of the IAM role that Amazon SageMaker can assume to access model
    /// artifacts and container images, and manage Amazon SageMaker Inference
    /// endpoints for model deployment.
    role_arn: []const u8,

    /// The duration for which you want the inference experiment to run. If you
    /// don't specify this field, the experiment automatically starts immediately
    /// upon creation and concludes after 7 days.
    schedule: ?InferenceExperimentSchedule = null,

    /// The configuration of `ShadowMode` inference experiment type. Use this field
    /// to specify a production variant which takes all the inference requests, and
    /// a shadow variant to which Amazon SageMaker replicates a percentage of the
    /// inference requests. For the shadow variant also specify the percentage of
    /// requests that Amazon SageMaker replicates.
    shadow_mode_config: ShadowModeConfig,

    /// Array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging your Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/ARG/latest/userguide/tagging.html).
    tags: ?[]const Tag = null,

    /// The type of the inference experiment that you want to run. The following
    /// types of experiments are possible:
    ///
    /// * `ShadowMode`: You can use this type to validate a shadow variant. For more
    ///   information, see [Shadow
    ///   tests](https://docs.aws.amazon.com/sagemaker/latest/dg/shadow-tests.html).
    @"type": InferenceExperimentType,

    pub const json_field_names = .{
        .data_storage_config = "DataStorageConfig",
        .description = "Description",
        .endpoint_name = "EndpointName",
        .kms_key = "KmsKey",
        .model_variants = "ModelVariants",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .shadow_mode_config = "ShadowModeConfig",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreateInferenceExperimentOutput = struct {
    /// The ARN for your inference experiment.
    inference_experiment_arn: []const u8,

    pub const json_field_names = .{
        .inference_experiment_arn = "InferenceExperimentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInferenceExperimentInput, options: CallOptions) !CreateInferenceExperimentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateInferenceExperiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInferenceExperimentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateInferenceExperimentOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
