const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceDataImportStrategy = @import("inference_data_import_strategy.zig").InferenceDataImportStrategy;
const LabelsInputConfiguration = @import("labels_input_configuration.zig").LabelsInputConfiguration;
const Tag = @import("tag.zig").Tag;
const ModelVersionStatus = @import("model_version_status.zig").ModelVersionStatus;

pub const ImportModelVersionInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token,
    /// Amazon Lookout for Equipment generates one.
    client_token: []const u8,

    /// The name of the dataset for the machine learning model being imported.
    dataset_name: []const u8,

    /// Indicates how to import the accumulated inference data when a model version
    /// is imported.
    /// The possible values are as follows:
    ///
    /// * NO_IMPORT – Don't import the data.
    ///
    /// * ADD_WHEN_EMPTY – Only import the data from the source model if there is no
    /// existing data in the target model.
    ///
    /// * OVERWRITE – Import the data from the source model and overwrite the
    /// existing data in the target model.
    inference_data_import_strategy: ?InferenceDataImportStrategy = null,

    labels_input_configuration: ?LabelsInputConfiguration = null,

    /// The name for the machine learning model to be created. If the model already
    /// exists,
    /// Amazon Lookout for Equipment creates a new version. If you do not specify
    /// this field, it is filled with the
    /// name of the source model.
    model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a role with permission to access the data
    /// source being
    /// used to create the machine learning model.
    role_arn: ?[]const u8 = null,

    /// Provides the identifier of the KMS key key used to encrypt model data by
    /// Amazon Lookout for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the model version to import.
    source_model_version_arn: []const u8,

    /// The tags associated with the machine learning model to be created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dataset_name = "DatasetName",
        .inference_data_import_strategy = "InferenceDataImportStrategy",
        .labels_input_configuration = "LabelsInputConfiguration",
        .model_name = "ModelName",
        .role_arn = "RoleArn",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .source_model_version_arn = "SourceModelVersionArn",
        .tags = "Tags",
    };
};

pub const ImportModelVersionOutput = struct {
    /// The Amazon Resource Name (ARN) of the model being created.
    model_arn: ?[]const u8 = null,

    /// The name for the machine learning model.
    model_name: ?[]const u8 = null,

    /// The version of the model being created.
    model_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model version being created.
    model_version_arn: ?[]const u8 = null,

    /// The status of the `ImportModelVersion` operation.
    status: ?ModelVersionStatus = null,

    pub const json_field_names = .{
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
        .model_version_arn = "ModelVersionArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportModelVersionInput, options: CallOptions) !ImportModelVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportModelVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ImportModelVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportModelVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportModelVersionOutput, body, allocator);
}
