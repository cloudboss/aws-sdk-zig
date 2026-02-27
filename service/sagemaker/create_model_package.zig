const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalInferenceSpecificationDefinition = @import("additional_inference_specification_definition.zig").AdditionalInferenceSpecificationDefinition;
const DriftCheckBaselines = @import("drift_check_baselines.zig").DriftCheckBaselines;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageModelCard = @import("model_package_model_card.zig").ModelPackageModelCard;
const ModelLifeCycle = @import("model_life_cycle.zig").ModelLifeCycle;
const ModelMetrics = @import("model_metrics.zig").ModelMetrics;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;
const ModelPackageSecurityConfig = @import("model_package_security_config.zig").ModelPackageSecurityConfig;
const SkipModelValidation = @import("skip_model_validation.zig").SkipModelValidation;
const SourceAlgorithmSpecification = @import("source_algorithm_specification.zig").SourceAlgorithmSpecification;
const Tag = @import("tag.zig").Tag;
const ModelPackageValidationSpecification = @import("model_package_validation_specification.zig").ModelPackageValidationSpecification;

pub const CreateModelPackageInput = struct {
    /// An array of additional Inference Specification objects. Each additional
    /// Inference Specification specifies artifacts based on this model package that
    /// can be used on inference endpoints. Generally used with SageMaker Neo to
    /// store the compiled artifacts.
    additional_inference_specifications: ?[]const AdditionalInferenceSpecificationDefinition = null,

    /// Whether to certify the model package for listing on Amazon Web Services
    /// Marketplace.
    ///
    /// This parameter is optional for unversioned models, and does not apply to
    /// versioned models.
    certify_for_marketplace: ?bool = null,

    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// The metadata properties associated with the model package versions.
    customer_metadata_properties: ?[]const aws.map.StringMapEntry = null,

    /// The machine learning domain of your model package and its components. Common
    /// machine learning domains include computer vision and natural language
    /// processing.
    domain: ?[]const u8 = null,

    /// Represents the drift check baselines that can be used when the model monitor
    /// is set using the model package. For more information, see the topic on
    /// [Drift Detection against Previous Baselines in SageMaker
    /// Pipelines](https://docs.aws.amazon.com/sagemaker/latest/dg/pipelines-quality-clarify-baseline-lifecycle.html#pipelines-quality-clarify-baseline-drift-detection) in the *Amazon SageMaker Developer Guide*.
    drift_check_baselines: ?DriftCheckBaselines = null,

    /// Specifies details about inference jobs that you can run with models based on
    /// this model package, including the following information:
    ///
    /// * The Amazon ECR paths of containers that contain the inference code and
    ///   model artifacts.
    /// * The instance types that the model package supports for transform jobs and
    ///   real-time endpoints used for inference.
    /// * The input and output content formats that the model package supports for
    ///   inference.
    inference_specification: ?InferenceSpecification = null,

    metadata_properties: ?MetadataProperties = null,

    /// Whether the model is approved for deployment.
    ///
    /// This parameter is optional for versioned models, and does not apply to
    /// unversioned models.
    ///
    /// For versioned models, the value of this parameter must be set to `Approved`
    /// to deploy the model.
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

    /// A structure that contains model metrics reports.
    model_metrics: ?ModelMetrics = null,

    /// A description of the model package.
    model_package_description: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the model package group that this
    /// model version belongs to.
    ///
    /// This parameter is required for versioned models, and does not apply to
    /// unversioned models.
    model_package_group_name: ?[]const u8 = null,

    /// The name of the model package. The name must have 1 to 63 characters. Valid
    /// characters are a-z, A-Z, 0-9, and - (hyphen).
    ///
    /// This parameter is required for unversioned models. It is not applicable to
    /// versioned models.
    model_package_name: ?[]const u8 = null,

    /// The package registration type of the model package input.
    model_package_registration_type: ?ModelPackageRegistrationType = null,

    /// The Amazon Simple Storage Service (Amazon S3) path where the sample payload
    /// is stored. This path must point to a single gzip compressed tar archive
    /// (.tar.gz suffix). This archive can hold multiple files that are all equally
    /// used in the load test. Each file in the archive must satisfy the size
    /// constraints of the
    /// [InvokeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_runtime_InvokeEndpoint.html#API_runtime_InvokeEndpoint_RequestSyntax) call.
    sample_payload_url: ?[]const u8 = null,

    /// The KMS Key ID (`KMSKeyId`) used for encryption of model package
    /// information.
    security_config: ?ModelPackageSecurityConfig = null,

    /// Indicates if you want to skip model validation.
    skip_model_validation: ?SkipModelValidation = null,

    /// Details about the algorithm that was used to create the model package.
    source_algorithm_specification: ?SourceAlgorithmSpecification = null,

    /// The URI of the source for the model package. If you want to clone a model
    /// package, set it to the model package Amazon Resource Name (ARN). If you want
    /// to register a model, set it to the model ARN.
    source_uri: ?[]const u8 = null,

    /// A list of key value pairs associated with the model. For more information,
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    ///
    /// If you supply `ModelPackageGroupName`, your model package belongs to the
    /// model group you specify and uses the tags associated with the model group.
    /// In this case, you cannot supply a `tag` argument.
    tags: ?[]const Tag = null,

    /// The machine learning task your model package accomplishes. Common machine
    /// learning tasks include object detection and image classification. The
    /// following tasks are supported by Inference Recommender:
    /// `"IMAGE_CLASSIFICATION"` | `"OBJECT_DETECTION"` | `"TEXT_GENERATION"`
    /// |`"IMAGE_SEGMENTATION"` | `"FILL_MASK"` | `"CLASSIFICATION"` |
    /// `"REGRESSION"` | `"OTHER"`.
    ///
    /// Specify "OTHER" if none of the tasks listed fit your use case.
    task: ?[]const u8 = null,

    /// Specifies configurations for one or more transform jobs that SageMaker runs
    /// to test the model package.
    validation_specification: ?ModelPackageValidationSpecification = null,

    pub const json_field_names = .{
        .additional_inference_specifications = "AdditionalInferenceSpecifications",
        .certify_for_marketplace = "CertifyForMarketplace",
        .client_token = "ClientToken",
        .customer_metadata_properties = "CustomerMetadataProperties",
        .domain = "Domain",
        .drift_check_baselines = "DriftCheckBaselines",
        .inference_specification = "InferenceSpecification",
        .metadata_properties = "MetadataProperties",
        .model_approval_status = "ModelApprovalStatus",
        .model_card = "ModelCard",
        .model_life_cycle = "ModelLifeCycle",
        .model_metrics = "ModelMetrics",
        .model_package_description = "ModelPackageDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_name = "ModelPackageName",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .sample_payload_url = "SamplePayloadUrl",
        .security_config = "SecurityConfig",
        .skip_model_validation = "SkipModelValidation",
        .source_algorithm_specification = "SourceAlgorithmSpecification",
        .source_uri = "SourceUri",
        .tags = "Tags",
        .task = "Task",
        .validation_specification = "ValidationSpecification",
    };
};

pub const CreateModelPackageOutput = struct {
    /// The Amazon Resource Name (ARN) of the new model package.
    model_package_arn: []const u8,

    pub const json_field_names = .{
        .model_package_arn = "ModelPackageArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelPackageInput, options: Options) !CreateModelPackageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateModelPackageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateModelPackage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateModelPackageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateModelPackageOutput, body, alloc);
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
