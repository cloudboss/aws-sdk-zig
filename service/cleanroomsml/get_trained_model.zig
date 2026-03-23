const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModelTrainingDataChannel = @import("model_training_data_channel.zig").ModelTrainingDataChannel;
const IncrementalTrainingDataChannelOutput = @import("incremental_training_data_channel_output.zig").IncrementalTrainingDataChannelOutput;
const LogsStatus = @import("logs_status.zig").LogsStatus;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const TrainedModelStatus = @import("trained_model_status.zig").TrainedModelStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

pub const GetTrainedModelInput = struct {
    /// The membership ID of the member that created the trained model that you are
    /// interested in.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model that you are interested
    /// in.
    trained_model_arn: []const u8,

    /// The version identifier of the trained model to retrieve. If not specified,
    /// the operation returns information about the latest version of the trained
    /// model.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .trained_model_arn = "trainedModelArn",
        .version_identifier = "versionIdentifier",
    };
};

pub const GetTrainedModelOutput = struct {
    /// The collaboration ID of the collaboration that contains the trained model.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that was used to create the trained model.
    configured_model_algorithm_association_arn: []const u8,

    /// The time at which the trained model was created.
    create_time: i64,

    /// The data channels that were used for the trained model.
    data_channels: ?[]const ModelTrainingDataChannel = null,

    /// The description of the trained model.
    description: ?[]const u8 = null,

    /// The EC2 environment that was used to create the trained model.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The hyperparameters that were used to create the trained model.
    hyperparameters: ?[]const aws.map.StringMapEntry = null,

    /// Information about the incremental training data channels used to create this
    /// version of the trained model. This includes details about the base model
    /// that was used for incremental training and the channel configuration.
    incremental_training_data_channels: ?[]const IncrementalTrainingDataChannelOutput = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the trained ML model and associated data.
    kms_key_arn: ?[]const u8 = null,

    /// The logs status for the trained model.
    logs_status: ?LogsStatus = null,

    /// Details about the logs status for the trained model.
    logs_status_details: ?[]const u8 = null,

    /// The membership ID of the member that created the trained model.
    membership_identifier: []const u8,

    /// The status of the model metrics.
    metrics_status: ?MetricsStatus = null,

    /// Details about the metrics status for the trained model.
    metrics_status_details: ?[]const u8 = null,

    /// The name of the trained model.
    name: []const u8,

    /// The EC2 resource configuration that was used to create the trained model.
    resource_config: ?ResourceConfig = null,

    /// The status of the trained model.
    status: TrainedModelStatus,

    status_details: ?StatusDetails = null,

    /// The stopping condition that was used to terminate model training.
    stopping_condition: ?StoppingCondition = null,

    /// The optional metadata that you applied to the resource to help you
    /// categorize and organize them. Each tag consists of a key and an optional
    /// value, both of which you define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case sensitive.
    /// * Do not use aws:, AWS:, or any upper or lowercase combination of such as a
    ///   prefix for keys as it is reserved for AWS use. You cannot edit or delete
    ///   tag keys with this prefix. Values can have this prefix. If a tag value has
    ///   aws as its prefix but the key does not, then Clean Rooms ML considers it
    ///   to be a user tag and will count against the limit of 50 tags. Tags with
    ///   only the key prefix of aws do not count against your tags per resource
    ///   limit.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the trained model.
    trained_model_arn: []const u8,

    /// Information about the training image container.
    training_container_image_digest: ?[]const u8 = null,

    /// The input mode that was used for accessing the training data when this
    /// trained model was created. This indicates how the training data was made
    /// available to the training algorithm.
    training_input_mode: ?TrainingInputMode = null,

    /// The most recent time at which the trained model was updated.
    update_time: i64,

    /// The version identifier of the trained model. This unique identifier
    /// distinguishes this version from other versions of the same trained model.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .create_time = "createTime",
        .data_channels = "dataChannels",
        .description = "description",
        .environment = "environment",
        .hyperparameters = "hyperparameters",
        .incremental_training_data_channels = "incrementalTrainingDataChannels",
        .kms_key_arn = "kmsKeyArn",
        .logs_status = "logsStatus",
        .logs_status_details = "logsStatusDetails",
        .membership_identifier = "membershipIdentifier",
        .metrics_status = "metricsStatus",
        .metrics_status_details = "metricsStatusDetails",
        .name = "name",
        .resource_config = "resourceConfig",
        .status = "status",
        .status_details = "statusDetails",
        .stopping_condition = "stoppingCondition",
        .tags = "tags",
        .trained_model_arn = "trainedModelArn",
        .training_container_image_digest = "trainingContainerImageDigest",
        .training_input_mode = "trainingInputMode",
        .update_time = "updateTime",
        .version_identifier = "versionIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrainedModelInput, options: CallOptions) !GetTrainedModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanrooms-ml");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrainedModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-models/");
    try path_buf.appendSlice(allocator, input.trained_model_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.version_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrainedModelOutput {
    var result: GetTrainedModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTrainedModelOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
