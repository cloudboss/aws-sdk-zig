const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportModelVersionInput, options: Options) !ImportModelVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lookoutequipment");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ImportModelVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ImportModelVersion");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ImportModelVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportModelVersionOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
