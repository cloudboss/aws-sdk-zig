const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalInferenceSpecificationDefinition = @import("additional_inference_specification_definition.zig").AdditionalInferenceSpecificationDefinition;
const UserContext = @import("user_context.zig").UserContext;
const DriftCheckBaselines = @import("drift_check_baselines.zig").DriftCheckBaselines;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageModelCard = @import("model_package_model_card.zig").ModelPackageModelCard;
const ModelLifeCycle = @import("model_life_cycle.zig").ModelLifeCycle;
const ModelMetrics = @import("model_metrics.zig").ModelMetrics;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;
const ModelPackageStatus = @import("model_package_status.zig").ModelPackageStatus;
const ModelPackageStatusDetails = @import("model_package_status_details.zig").ModelPackageStatusDetails;
const ModelPackageSecurityConfig = @import("model_package_security_config.zig").ModelPackageSecurityConfig;
const SkipModelValidation = @import("skip_model_validation.zig").SkipModelValidation;
const SourceAlgorithmSpecification = @import("source_algorithm_specification.zig").SourceAlgorithmSpecification;
const ModelPackageValidationSpecification = @import("model_package_validation_specification.zig").ModelPackageValidationSpecification;

pub const DescribeModelPackageInput = struct {
    /// The name or Amazon Resource Name (ARN) of the model package to describe.
    ///
    /// When you specify a name, the name must have 1 to 63 characters. Valid
    /// characters are a-z, A-Z, 0-9, and - (hyphen).
    model_package_name: []const u8,

    pub const json_field_names = .{
        .model_package_name = "ModelPackageName",
    };
};

pub const DescribeModelPackageOutput = struct {
    /// An array of additional Inference Specification objects. Each additional
    /// Inference Specification specifies artifacts based on this model package that
    /// can be used on inference endpoints. Generally used with SageMaker Neo to
    /// store the compiled artifacts.
    additional_inference_specifications: ?[]const AdditionalInferenceSpecificationDefinition = null,

    /// A description provided for the model approval.
    approval_description: ?[]const u8 = null,

    /// Whether the model package is certified for listing on Amazon Web Services
    /// Marketplace.
    certify_for_marketplace: ?bool = null,

    created_by: ?UserContext = null,

    /// A timestamp specifying when the model package was created.
    creation_time: i64,

    /// The metadata properties associated with the model package versions.
    customer_metadata_properties: ?[]const aws.map.StringMapEntry = null,

    /// The machine learning domain of the model package you specified. Common
    /// machine learning domains include computer vision and natural language
    /// processing.
    domain: ?[]const u8 = null,

    /// Represents the drift check baselines that can be used when the model monitor
    /// is set using the model package. For more information, see the topic on
    /// [Drift Detection against Previous Baselines in SageMaker
    /// Pipelines](https://docs.aws.amazon.com/sagemaker/latest/dg/pipelines-quality-clarify-baseline-lifecycle.html#pipelines-quality-clarify-baseline-drift-detection) in the *Amazon SageMaker Developer Guide*.
    drift_check_baselines: ?DriftCheckBaselines = null,

    /// Details about inference jobs that you can run with models based on this
    /// model package.
    inference_specification: ?InferenceSpecification = null,

    last_modified_by: ?UserContext = null,

    /// The last time that the model package was modified.
    last_modified_time: ?i64 = null,

    metadata_properties: ?MetadataProperties = null,

    /// The approval status of the model package.
    model_approval_status: ?ModelApprovalStatus = null,

    /// The model card associated with the model package. Since
    /// `ModelPackageModelCard` is tied to a model package, it is a specific usage
    /// of a model card and its schema is simplified compared to the schema of
    /// `ModelCard`. The `ModelPackageModelCard` schema does not include
    /// `model_package_details`, and `model_overview` is composed of the
    /// `model_creator` and `model_artifact` properties. For more information about
    /// the model package model card schema, see [Model package model card
    /// schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-registry-details.html#model-card-schema). For more information about the model card associated with the model package, see [View the Details of a Model Version](https://docs.aws.amazon.com/sagemaker/latest/dg/model-registry-details.html).
    model_card: ?ModelPackageModelCard = null,

    /// A structure describing the current state of the model in its life cycle.
    model_life_cycle: ?ModelLifeCycle = null,

    /// Metrics for the model.
    model_metrics: ?ModelMetrics = null,

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: []const u8,

    /// A brief summary of the model package.
    model_package_description: ?[]const u8 = null,

    /// If the model is a versioned model, the name of the model group that the
    /// versioned model belongs to.
    model_package_group_name: ?[]const u8 = null,

    /// The name of the model package being described.
    model_package_name: []const u8,

    /// The package registration type of the model package output.
    model_package_registration_type: ?ModelPackageRegistrationType = null,

    /// The current status of the model package.
    model_package_status: ModelPackageStatus,

    /// Details about the current status of the model package.
    model_package_status_details: ?ModelPackageStatusDetails = null,

    /// The version of the model package.
    model_package_version: ?i32 = null,

    /// The Amazon Simple Storage Service (Amazon S3) path where the sample payload
    /// are stored. This path points to a single gzip compressed tar archive
    /// (.tar.gz suffix).
    sample_payload_url: ?[]const u8 = null,

    /// The KMS Key ID (`KMSKeyId`) used for encryption of model package
    /// information.
    security_config: ?ModelPackageSecurityConfig = null,

    /// Indicates if you want to skip model validation.
    skip_model_validation: ?SkipModelValidation = null,

    /// Details about the algorithm that was used to create the model package.
    source_algorithm_specification: ?SourceAlgorithmSpecification = null,

    /// The URI of the source for the model package.
    source_uri: ?[]const u8 = null,

    /// The machine learning task you specified that your model package
    /// accomplishes. Common machine learning tasks include object detection and
    /// image classification.
    task: ?[]const u8 = null,

    /// Configurations for one or more transform jobs that SageMaker runs to test
    /// the model package.
    validation_specification: ?ModelPackageValidationSpecification = null,

    pub const json_field_names = .{
        .additional_inference_specifications = "AdditionalInferenceSpecifications",
        .approval_description = "ApprovalDescription",
        .certify_for_marketplace = "CertifyForMarketplace",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .customer_metadata_properties = "CustomerMetadataProperties",
        .domain = "Domain",
        .drift_check_baselines = "DriftCheckBaselines",
        .inference_specification = "InferenceSpecification",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .metadata_properties = "MetadataProperties",
        .model_approval_status = "ModelApprovalStatus",
        .model_card = "ModelCard",
        .model_life_cycle = "ModelLifeCycle",
        .model_metrics = "ModelMetrics",
        .model_package_arn = "ModelPackageArn",
        .model_package_description = "ModelPackageDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_name = "ModelPackageName",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .model_package_status = "ModelPackageStatus",
        .model_package_status_details = "ModelPackageStatusDetails",
        .model_package_version = "ModelPackageVersion",
        .sample_payload_url = "SamplePayloadUrl",
        .security_config = "SecurityConfig",
        .skip_model_validation = "SkipModelValidation",
        .source_algorithm_specification = "SourceAlgorithmSpecification",
        .source_uri = "SourceUri",
        .task = "Task",
        .validation_specification = "ValidationSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelPackageInput, options: CallOptions) !DescribeModelPackageOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelPackageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModelPackage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelPackageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelPackageOutput, body, allocator);
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
