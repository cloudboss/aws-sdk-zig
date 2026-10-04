const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomModelInput, options: CallOptions) !GetCustomModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-models/");
    try path_buf.appendSlice(allocator, input.model_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomModelOutput {
    const result: GetCustomModelOutput = try aws.json.parseJsonObject(
        GetCustomModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
