const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AutoPromotionResult = @import("auto_promotion_result.zig").AutoPromotionResult;
const DataPreProcessingConfiguration = @import("data_pre_processing_configuration.zig").DataPreProcessingConfiguration;
const LabelsInputConfiguration = @import("labels_input_configuration.zig").LabelsInputConfiguration;
const ModelDiagnosticsOutputConfiguration = @import("model_diagnostics_output_configuration.zig").ModelDiagnosticsOutputConfiguration;
const S3Object = @import("s3_object.zig").S3Object;
const ModelQuality = @import("model_quality.zig").ModelQuality;
const ModelVersionSourceType = @import("model_version_source_type.zig").ModelVersionSourceType;
const ModelVersionStatus = @import("model_version_status.zig").ModelVersionStatus;

pub const DescribeModelVersionInput = struct {
    /// The name of the machine learning model that this version belongs to.
    model_name: []const u8,

    /// The version of the machine learning model.
    model_version: i64,

    pub const json_field_names = .{
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};

pub const DescribeModelVersionOutput = struct {
    /// Indicates whether the model version was promoted to be the active version
    /// after
    /// retraining or if there was an error with or cancellation of the retraining.
    auto_promotion_result: ?AutoPromotionResult = null,

    /// Indicates the reason for the `AutoPromotionResult`. For example, a model
    /// might not be promoted if its performance was worse than the active version,
    /// if there was an
    /// error during training, or if the retraining scheduler was using `MANUAL`
    /// promote
    /// mode. The model will be promoted in `MANAGED` promote mode if the
    /// performance is
    /// better than the previous model.
    auto_promotion_result_reason: ?[]const u8 = null,

    /// Indicates the time and date at which the machine learning model version was
    /// created.
    created_at: ?i64 = null,

    data_pre_processing_configuration: ?DataPreProcessingConfiguration = null,

    /// The Amazon Resource Name (ARN) of the dataset used to train the model
    /// version.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset used to train the model version.
    dataset_name: ?[]const u8 = null,

    /// The date on which the data in the evaluation set began being gathered. If
    /// you imported
    /// the version, this is the date that the evaluation set data in the source
    /// version finished
    /// being gathered.
    evaluation_data_end_time: ?i64 = null,

    /// The date on which the data in the evaluation set began being gathered. If
    /// you imported
    /// the version, this is the date that the evaluation set data in the source
    /// version began
    /// being gathered.
    evaluation_data_start_time: ?i64 = null,

    /// The failure message if the training of the model version failed.
    failed_reason: ?[]const u8 = null,

    /// The size in bytes of the imported data. This field appears if the model
    /// version was
    /// imported.
    imported_data_size_in_bytes: ?i64 = null,

    /// The date and time when the import job completed. This field appears if the
    /// model version
    /// was imported.
    import_job_end_time: ?i64 = null,

    /// The date and time when the import job began. This field appears if the model
    /// version was
    /// imported.
    import_job_start_time: ?i64 = null,

    labels_input_configuration: ?LabelsInputConfiguration = null,

    /// Indicates the last time the machine learning model version was updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the parent machine learning model that
    /// this version
    /// belong to.
    model_arn: ?[]const u8 = null,

    /// The Amazon S3 location where Amazon Lookout for Equipment saves the
    /// pointwise model diagnostics for the model version.
    model_diagnostics_output_configuration: ?ModelDiagnosticsOutputConfiguration = null,

    /// The Amazon S3 output prefix for where Lookout for Equipment saves the
    /// pointwise model diagnostics for the model version.
    model_diagnostics_results_object: ?S3Object = null,

    /// Shows an aggregated summary, in JSON format, of the model's performance
    /// within the
    /// evaluation time range. These metrics are created when evaluating the model.
    model_metrics: ?[]const u8 = null,

    /// The name of the machine learning model that this version belongs to.
    model_name: ?[]const u8 = null,

    /// Provides a quality assessment for a model that uses labels. If Lookout for
    /// Equipment determines that the
    /// model quality is poor based on training metrics, the value is
    /// `POOR_QUALITY_DETECTED`. Otherwise, the value is
    /// `QUALITY_THRESHOLD_MET`.
    ///
    /// If the model is unlabeled, the model quality can't
    /// be assessed and the value of `ModelQuality` is
    /// `CANNOT_DETERMINE_QUALITY`. In this situation, you can get a model quality
    /// assessment by adding labels to the input dataset and retraining the model.
    ///
    /// For information about using labels with your models, see [Understanding
    /// labeling](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/understanding-labeling.html).
    ///
    /// For information about improving the quality of a model, see [Best practices
    /// with
    /// Amazon Lookout for
    /// Equipment](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/best-practices.html).
    model_quality: ?ModelQuality = null,

    /// The version of the machine learning model.
    model_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model version.
    model_version_arn: ?[]const u8 = null,

    /// Indicates that the asset associated with this sensor has been shut off. As
    /// long as this
    /// condition is met, Lookout for Equipment will not use data from this asset
    /// for training,
    /// evaluation, or inference.
    off_condition: ?[]const u8 = null,

    /// If the model version was retrained, this field shows a summary of the
    /// performance of the
    /// prior model on the new training range. You can use the information in this
    /// JSON-formatted
    /// object to compare the new model version and the prior model version.
    prior_model_metrics: ?[]const u8 = null,

    /// Indicates the number of days of data used in the most recent scheduled
    /// retraining run.
    retraining_available_data_in_days: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the role that was used to train the model
    /// version.
    role_arn: ?[]const u8 = null,

    /// The schema of the data used to train the model version.
    schema: ?[]const u8 = null,

    /// The identifier of the KMS key key used to encrypt model version data by
    /// Amazon Lookout for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// If model version was imported, then this field is the arn of the source
    /// model
    /// version.
    source_model_version_arn: ?[]const u8 = null,

    /// Indicates whether this model version was created by training or by
    /// importing.
    source_type: ?ModelVersionSourceType = null,

    /// The current status of the model version.
    status: ?ModelVersionStatus = null,

    /// The date on which the training data finished being gathered. If you imported
    /// the
    /// version, this is the date that the training data in the source version
    /// finished being
    /// gathered.
    training_data_end_time: ?i64 = null,

    /// The date on which the training data began being gathered. If you imported
    /// the version,
    /// this is the date that the training data in the source version began being
    /// gathered.
    training_data_start_time: ?i64 = null,

    /// The time when the training of the version completed.
    training_execution_end_time: ?i64 = null,

    /// The time when the training of the version began.
    training_execution_start_time: ?i64 = null,

    pub const json_field_names = .{
        .auto_promotion_result = "AutoPromotionResult",
        .auto_promotion_result_reason = "AutoPromotionResultReason",
        .created_at = "CreatedAt",
        .data_pre_processing_configuration = "DataPreProcessingConfiguration",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .evaluation_data_end_time = "EvaluationDataEndTime",
        .evaluation_data_start_time = "EvaluationDataStartTime",
        .failed_reason = "FailedReason",
        .imported_data_size_in_bytes = "ImportedDataSizeInBytes",
        .import_job_end_time = "ImportJobEndTime",
        .import_job_start_time = "ImportJobStartTime",
        .labels_input_configuration = "LabelsInputConfiguration",
        .last_updated_time = "LastUpdatedTime",
        .model_arn = "ModelArn",
        .model_diagnostics_output_configuration = "ModelDiagnosticsOutputConfiguration",
        .model_diagnostics_results_object = "ModelDiagnosticsResultsObject",
        .model_metrics = "ModelMetrics",
        .model_name = "ModelName",
        .model_quality = "ModelQuality",
        .model_version = "ModelVersion",
        .model_version_arn = "ModelVersionArn",
        .off_condition = "OffCondition",
        .prior_model_metrics = "PriorModelMetrics",
        .retraining_available_data_in_days = "RetrainingAvailableDataInDays",
        .role_arn = "RoleArn",
        .schema = "Schema",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .source_model_version_arn = "SourceModelVersionArn",
        .source_type = "SourceType",
        .status = "Status",
        .training_data_end_time = "TrainingDataEndTime",
        .training_data_start_time = "TrainingDataStartTime",
        .training_execution_end_time = "TrainingExecutionEndTime",
        .training_execution_start_time = "TrainingExecutionStartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelVersionInput, options: CallOptions) !DescribeModelVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeModelVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeModelVersionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
