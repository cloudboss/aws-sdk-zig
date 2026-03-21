const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalInferenceSpecificationDefinition = @import("additional_inference_specification_definition.zig").AdditionalInferenceSpecificationDefinition;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageModelCard = @import("model_package_model_card.zig").ModelPackageModelCard;
const ModelLifeCycle = @import("model_life_cycle.zig").ModelLifeCycle;
const ModelPackageRegistrationType = @import("model_package_registration_type.zig").ModelPackageRegistrationType;

pub const UpdateModelPackageInput = struct {
    /// An array of additional Inference Specification objects to be added to the
    /// existing array additional Inference Specification. Total number of
    /// additional Inference Specifications can not exceed 15. Each additional
    /// Inference Specification specifies artifacts based on this model package that
    /// can be used on inference endpoints. Generally used with SageMaker Neo to
    /// store the compiled artifacts.
    additional_inference_specifications_to_add: ?[]const AdditionalInferenceSpecificationDefinition = null,

    /// A description for the approval status of the model.
    approval_description: ?[]const u8 = null,

    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// The metadata properties associated with the model package versions.
    customer_metadata_properties: ?[]const aws.map.StringMapEntry = null,

    /// The metadata properties associated with the model package versions to
    /// remove.
    customer_metadata_properties_to_remove: ?[]const []const u8 = null,

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

    /// The approval status of the model.
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

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: []const u8,

    /// The package registration type of the model package input.
    model_package_registration_type: ?ModelPackageRegistrationType = null,

    /// The URI of the source for the model package.
    source_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_inference_specifications_to_add = "AdditionalInferenceSpecificationsToAdd",
        .approval_description = "ApprovalDescription",
        .client_token = "ClientToken",
        .customer_metadata_properties = "CustomerMetadataProperties",
        .customer_metadata_properties_to_remove = "CustomerMetadataPropertiesToRemove",
        .inference_specification = "InferenceSpecification",
        .model_approval_status = "ModelApprovalStatus",
        .model_card = "ModelCard",
        .model_life_cycle = "ModelLifeCycle",
        .model_package_arn = "ModelPackageArn",
        .model_package_registration_type = "ModelPackageRegistrationType",
        .source_uri = "SourceUri",
    };
};

pub const UpdateModelPackageOutput = struct {
    /// The Amazon Resource Name (ARN) of the model.
    model_package_arn: []const u8,

    pub const json_field_names = .{
        .model_package_arn = "ModelPackageArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateModelPackageInput, options: CallOptions) !UpdateModelPackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateModelPackageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateModelPackage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateModelPackageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateModelPackageOutput, body, allocator);
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
