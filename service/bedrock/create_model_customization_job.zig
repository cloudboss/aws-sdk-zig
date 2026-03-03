const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomizationConfig = @import("customization_config.zig").CustomizationConfig;
const CustomizationType = @import("customization_type.zig").CustomizationType;
const Tag = @import("tag.zig").Tag;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const TrainingDataConfig = @import("training_data_config.zig").TrainingDataConfig;
const ValidationDataConfig = @import("validation_data_config.zig").ValidationDataConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateModelCustomizationJobInput = struct {
    /// Name of the base model.
    base_model_identifier: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The customization configuration for the model customization job.
    customization_config: ?CustomizationConfig = null,

    /// The customization type.
    customization_type: ?CustomizationType = null,

    /// The custom model is encrypted at rest using this key.
    custom_model_kms_key_id: ?[]const u8 = null,

    /// A name for the resulting custom model.
    custom_model_name: []const u8,

    /// Tags to attach to the resulting custom model.
    custom_model_tags: ?[]const Tag = null,

    /// Parameters related to tuning the model. For details on the format for
    /// different models, see [Custom model
    /// hyperparameters](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html).
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// A name for the fine-tuning job.
    job_name: []const u8,

    /// Tags to attach to the job.
    job_tags: ?[]const Tag = null,

    /// S3 location for the output data.
    output_data_config: OutputDataConfig,

    /// The Amazon Resource Name (ARN) of an IAM service role that Amazon Bedrock
    /// can assume to perform tasks on your behalf. For example, during model
    /// training, Amazon Bedrock needs your permission to read input data from an S3
    /// bucket, write model artifacts to an S3 bucket. To pass this role to Amazon
    /// Bedrock, the caller of this API must have the `iam:PassRole` permission.
    role_arn: []const u8,

    /// Information about the training dataset.
    training_data_config: TrainingDataConfig,

    /// Information about the validation dataset.
    validation_data_config: ?ValidationDataConfig = null,

    /// The configuration of the Virtual Private Cloud (VPC) that contains the
    /// resources that you're using for this job. For more information, see [Protect
    /// your model customization jobs using a
    /// VPC](https://docs.aws.amazon.com/bedrock/latest/userguide/vpc-model-customization.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .base_model_identifier = "baseModelIdentifier",
        .client_request_token = "clientRequestToken",
        .customization_config = "customizationConfig",
        .customization_type = "customizationType",
        .custom_model_kms_key_id = "customModelKmsKeyId",
        .custom_model_name = "customModelName",
        .custom_model_tags = "customModelTags",
        .hyper_parameters = "hyperParameters",
        .job_name = "jobName",
        .job_tags = "jobTags",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
        .training_data_config = "trainingDataConfig",
        .validation_data_config = "validationDataConfig",
        .vpc_config = "vpcConfig",
    };
};

pub const CreateModelCustomizationJobOutput = struct {
    /// Amazon Resource Name (ARN) of the fine tuning job
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelCustomizationJobInput, options: Options) !CreateModelCustomizationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelCustomizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/model-customization-jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"baseModelIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.base_model_identifier), input.base_model_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customization_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customizationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customization_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customizationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_model_kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customModelKmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"customModelName\":");
    try aws.json.writeValue(@TypeOf(input.custom_model_name), input.custom_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.custom_model_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customModelTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hyper_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hyperParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (input.job_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_data_config), input.output_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"trainingDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.training_data_config), input.training_data_config, allocator, &body_buf);
    has_prev = true;
    if (input.validation_data_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"validationDataConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelCustomizationJobOutput {
    var result: CreateModelCustomizationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateModelCustomizationJobOutput, body, allocator);
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
