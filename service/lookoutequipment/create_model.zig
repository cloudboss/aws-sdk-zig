const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataPreProcessingConfiguration = @import("data_pre_processing_configuration.zig").DataPreProcessingConfiguration;
const DatasetSchema = @import("dataset_schema.zig").DatasetSchema;
const LabelsInputConfiguration = @import("labels_input_configuration.zig").LabelsInputConfiguration;
const ModelDiagnosticsOutputConfiguration = @import("model_diagnostics_output_configuration.zig").ModelDiagnosticsOutputConfiguration;
const Tag = @import("tag.zig").Tag;
const ModelStatus = @import("model_status.zig").ModelStatus;

pub const CreateModelInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token, Amazon
    /// Lookout for Equipment generates one.
    client_token: []const u8,

    /// The configuration is the `TargetSamplingRate`, which is the sampling rate of
    /// the data after post processing by Amazon Lookout for Equipment. For example,
    /// if you provide data that has been
    /// collected at a 1 second level and you want the system to resample the data
    /// at a 1 minute
    /// rate before training, the `TargetSamplingRate` is 1 minute.
    ///
    /// When providing a value for the `TargetSamplingRate`, you must attach the
    /// prefix "PT" to the rate you want. The value for a 1 second rate is therefore
    /// *PT1S*, the value for a 15 minute rate is *PT15M*,
    /// and the value for a 1 hour rate is *PT1H*
    data_pre_processing_configuration: ?DataPreProcessingConfiguration = null,

    /// The name of the dataset for the machine learning model being created.
    dataset_name: []const u8,

    /// The data schema for the machine learning model being created.
    dataset_schema: ?DatasetSchema = null,

    /// Indicates the time reference in the dataset that should be used to end the
    /// subset of
    /// evaluation data for the machine learning model.
    evaluation_data_end_time: ?i64 = null,

    /// Indicates the time reference in the dataset that should be used to begin the
    /// subset of
    /// evaluation data for the machine learning model.
    evaluation_data_start_time: ?i64 = null,

    /// The input configuration for the labels being used for the machine learning
    /// model that's
    /// being created.
    labels_input_configuration: ?LabelsInputConfiguration = null,

    /// The Amazon S3 location where you want Amazon Lookout for Equipment to save
    /// the pointwise model diagnostics.
    ///
    /// You must also specify the `RoleArn` request parameter.
    model_diagnostics_output_configuration: ?ModelDiagnosticsOutputConfiguration = null,

    /// The name for the machine learning model to be created.
    model_name: []const u8,

    /// Indicates that the asset associated with this sensor has been shut off. As
    /// long as this
    /// condition is met, Lookout for Equipment will not use data from this asset
    /// for training,
    /// evaluation, or inference.
    off_condition: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source
    /// being used to create the machine learning model.
    role_arn: ?[]const u8 = null,

    /// Provides the identifier of the KMS key used to encrypt model data by Amazon
    /// Lookout
    /// for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// Any tags associated with the machine learning model being created.
    tags: ?[]const Tag = null,

    /// Indicates the time reference in the dataset that should be used to end the
    /// subset of
    /// training data for the machine learning model.
    training_data_end_time: ?i64 = null,

    /// Indicates the time reference in the dataset that should be used to begin the
    /// subset of
    /// training data for the machine learning model.
    training_data_start_time: ?i64 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_pre_processing_configuration = "DataPreProcessingConfiguration",
        .dataset_name = "DatasetName",
        .dataset_schema = "DatasetSchema",
        .evaluation_data_end_time = "EvaluationDataEndTime",
        .evaluation_data_start_time = "EvaluationDataStartTime",
        .labels_input_configuration = "LabelsInputConfiguration",
        .model_diagnostics_output_configuration = "ModelDiagnosticsOutputConfiguration",
        .model_name = "ModelName",
        .off_condition = "OffCondition",
        .role_arn = "RoleArn",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .tags = "Tags",
        .training_data_end_time = "TrainingDataEndTime",
        .training_data_start_time = "TrainingDataStartTime",
    };
};

pub const CreateModelOutput = struct {
    /// The Amazon Resource Name (ARN) of the model being created.
    model_arn: ?[]const u8 = null,

    /// Indicates the status of the `CreateModel` operation.
    status: ?ModelStatus = null,

    pub const json_field_names = .{
        .model_arn = "ModelArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelInput, options: CallOptions) !CreateModelOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.CreateModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateModelOutput, body, allocator);
}
