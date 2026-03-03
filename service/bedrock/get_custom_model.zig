const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomizationConfig = @import("customization_config.zig").CustomizationConfig;
const CustomizationType = @import("customization_type.zig").CustomizationType;
const ModelStatus = @import("model_status.zig").ModelStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const TrainingDataConfig = @import("training_data_config.zig").TrainingDataConfig;
const TrainingMetrics = @import("training_metrics.zig").TrainingMetrics;
const ValidationDataConfig = @import("validation_data_config.zig").ValidationDataConfig;
const ValidatorMetric = @import("validator_metric.zig").ValidatorMetric;

pub const GetCustomModelInput = struct {
    /// Name or Amazon Resource Name (ARN) of the custom model.
    model_identifier: []const u8,

    pub const json_field_names = .{
        .model_identifier = "modelIdentifier",
    };
};

pub const GetCustomModelOutput = struct {
    /// Amazon Resource Name (ARN) of the base model.
    base_model_arn: ?[]const u8 = null,

    /// Creation time of the model.
    creation_time: i64,

    /// The customization configuration for the custom model.
    customization_config: ?CustomizationConfig = null,

    /// The type of model customization.
    customization_type: ?CustomizationType = null,

    /// A failure message for any issues that occurred when creating the custom
    /// model. This is included for only a failed CreateCustomModel operation.
    failure_message: ?[]const u8 = null,

    /// Hyperparameter values associated with this model. For details on the format
    /// for different models, see [Custom model
    /// hyperparameters](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html).
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Job Amazon Resource Name (ARN) associated with this model. For models that
    /// you create with the
    /// [CreateCustomModel](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateCustomModel.html) API operation, this is `NULL`.
    job_arn: ?[]const u8 = null,

    /// Job name associated with this model.
    job_name: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) associated with this model.
    model_arn: []const u8,

    /// The custom model is encrypted at rest using this key.
    model_kms_key_arn: ?[]const u8 = null,

    /// Model name associated with this model.
    model_name: []const u8,

    /// The current status of the custom model. Possible values include:
    ///
    /// * `Creating` - The model is being created and validated.
    /// * `Active` - The model has been successfully created and is ready for use.
    /// * `Failed` - The model creation process failed. Check the `failureMessage`
    ///   field for details.
    model_status: ?ModelStatus = null,

    /// Output data configuration associated with this custom model.
    output_data_config: ?OutputDataConfig = null,

    /// Contains information about the training dataset.
    training_data_config: ?TrainingDataConfig = null,

    /// Contains training metrics from the job creation.
    training_metrics: ?TrainingMetrics = null,

    /// Contains information about the validation dataset.
    validation_data_config: ?ValidationDataConfig = null,

    /// The validation metrics from the job creation.
    validation_metrics: ?[]const ValidatorMetric = null,

    pub const json_field_names = .{
        .base_model_arn = "baseModelArn",
        .creation_time = "creationTime",
        .customization_config = "customizationConfig",
        .customization_type = "customizationType",
        .failure_message = "failureMessage",
        .hyper_parameters = "hyperParameters",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .model_arn = "modelArn",
        .model_kms_key_arn = "modelKmsKeyArn",
        .model_name = "modelName",
        .model_status = "modelStatus",
        .output_data_config = "outputDataConfig",
        .training_data_config = "trainingDataConfig",
        .training_metrics = "trainingMetrics",
        .validation_data_config = "validationDataConfig",
        .validation_metrics = "validationMetrics",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomModelInput, options: Options) !GetCustomModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/custom-models/");
    try path_buf.appendSlice(allocator, input.model_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomModelOutput {
    var result: GetCustomModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCustomModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
