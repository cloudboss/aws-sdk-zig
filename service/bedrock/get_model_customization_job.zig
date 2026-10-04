const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomizationConfig = @import("customization_config.zig").CustomizationConfig;
const CustomizationType = @import("customization_type.zig").CustomizationType;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ModelCustomizationJobStatus = @import("model_customization_job_status.zig").ModelCustomizationJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;
const TrainingDataConfig = @import("training_data_config.zig").TrainingDataConfig;
const TrainingMetrics = @import("training_metrics.zig").TrainingMetrics;
const ValidationDataConfig = @import("validation_data_config.zig").ValidationDataConfig;
const ValidatorMetric = @import("validator_metric.zig").ValidatorMetric;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const GetModelCustomizationJobInput = struct {
    /// Identifier for the customization job.
    job_identifier: []const u8,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
    };
};

pub const GetModelCustomizationJobOutput = struct {
    /// Amazon Resource Name (ARN) of the base model.
    base_model_arn: []const u8,

    /// The token that you specified in the `CreateCustomizationJob` request.
    client_request_token: ?[]const u8 = null,

    /// Time that the resource was created.
    creation_time: i64,

    /// The customization configuration for the model customization job.
    customization_config: ?CustomizationConfig = null,

    /// The type of model customization.
    customization_type: ?CustomizationType = null,

    /// Time that the resource transitioned to terminal state.
    end_time: ?i64 = null,

    /// Information about why the job failed.
    failure_message: ?[]const u8 = null,

    /// The hyperparameter values for the job. For details on the format for
    /// different models, see [Custom model
    /// hyperparameters](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models-hp.html).
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the customization job.
    job_arn: []const u8,

    /// The name of the customization job.
    job_name: []const u8,

    /// Time that the resource was last modified.
    last_modified_time: ?i64 = null,

    /// Output data configuration
    output_data_config: ?OutputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the output model.
    output_model_arn: ?[]const u8 = null,

    /// The custom model is encrypted at rest using this key.
    output_model_kms_key_arn: ?[]const u8 = null,

    /// The name of the output model.
    output_model_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role.
    role_arn: []const u8,

    /// The status of the job. A successful job transitions from in-progress to
    /// completed when the output model is ready to use. If the job failed, the
    /// failure message contains information about why the job failed.
    status: ?ModelCustomizationJobStatus = null,

    /// For a Distillation job, the details about the statuses of the sub-tasks of
    /// the customization job.
    status_details: ?StatusDetails = null,

    /// Contains information about the training dataset.
    training_data_config: ?TrainingDataConfig = null,

    /// Contains training metrics from the job creation.
    training_metrics: ?TrainingMetrics = null,

    /// Contains information about the validation dataset.
    validation_data_config: ?ValidationDataConfig = null,

    /// The loss metric for each validator that you provided in the createjob
    /// request.
    validation_metrics: ?[]const ValidatorMetric = null,

    /// VPC configuration for the custom model job.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .base_model_arn = "baseModelArn",
        .client_request_token = "clientRequestToken",
        .creation_time = "creationTime",
        .customization_config = "customizationConfig",
        .customization_type = "customizationType",
        .end_time = "endTime",
        .failure_message = "failureMessage",
        .hyper_parameters = "hyperParameters",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .output_data_config = "outputDataConfig",
        .output_model_arn = "outputModelArn",
        .output_model_kms_key_arn = "outputModelKmsKeyArn",
        .output_model_name = "outputModelName",
        .role_arn = "roleArn",
        .status = "status",
        .status_details = "statusDetails",
        .training_data_config = "trainingDataConfig",
        .training_metrics = "trainingMetrics",
        .validation_data_config = "validationDataConfig",
        .validation_metrics = "validationMetrics",
        .vpc_config = "vpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelCustomizationJobInput, options: CallOptions) !GetModelCustomizationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelCustomizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/model-customization-jobs/");
    try path_buf.appendSlice(allocator, input.job_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelCustomizationJobOutput {
    const result: GetModelCustomizationJobOutput = try aws.json.parseJsonObject(
        GetModelCustomizationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
