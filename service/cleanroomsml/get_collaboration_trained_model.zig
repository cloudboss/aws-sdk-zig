const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IncrementalTrainingDataChannelOutput = @import("incremental_training_data_channel_output.zig").IncrementalTrainingDataChannelOutput;
const LogsStatus = @import("logs_status.zig").LogsStatus;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const TrainedModelStatus = @import("trained_model_status.zig").TrainedModelStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

pub const GetCollaborationTrainedModelInput = struct {
    /// The collaboration ID that contains the trained model that you want to return
    /// information about.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model that you want to return
    /// information about.
    trained_model_arn: []const u8,

    /// The version identifier of the trained model to retrieve. If not specified,
    /// the operation returns information about the latest version of the trained
    /// model.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .trained_model_arn = "trainedModelArn",
        .version_identifier = "versionIdentifier",
    };
};

pub const GetCollaborationTrainedModelOutput = struct {
    /// The collaboration ID of the collaboration that contains the trained model.
    collaboration_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that was used to create this trained model.
    configured_model_algorithm_association_arn: []const u8,

    /// The time at which the trained model was created.
    create_time: i64,

    /// The account ID of the member that created the trained model.
    creator_account_id: []const u8,

    /// The description of the trained model.
    description: ?[]const u8 = null,

    /// Information about the incremental training data channels used to create this
    /// version of the trained model. This includes details about the base model
    /// that was used for incremental training and the channel configuration.
    incremental_training_data_channels: ?[]const IncrementalTrainingDataChannelOutput = null,

    /// Status information for the logs.
    logs_status: ?LogsStatus = null,

    /// Details about the status information for the logs.
    logs_status_details: ?[]const u8 = null,

    /// The membership ID of the member that created the trained model.
    membership_identifier: []const u8,

    /// The status of the model metrics.
    metrics_status: ?MetricsStatus = null,

    /// Details about the status information for the model metrics.
    metrics_status_details: ?[]const u8 = null,

    /// The name of the trained model.
    name: []const u8,

    /// The EC2 resource configuration that was used to train this model.
    resource_config: ?ResourceConfig = null,

    /// The status of the trained model.
    status: TrainedModelStatus,

    status_details: ?StatusDetails = null,

    /// The stopping condition that determined when model training ended.
    stopping_condition: ?StoppingCondition = null,

    /// The Amazon Resource Name (ARN) of the trained model.
    trained_model_arn: []const u8,

    /// Information about the training container image.
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
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .incremental_training_data_channels = "incrementalTrainingDataChannels",
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
        .trained_model_arn = "trainedModelArn",
        .training_container_image_digest = "trainingContainerImageDigest",
        .training_input_mode = "trainingInputMode",
        .update_time = "updateTime",
        .version_identifier = "versionIdentifier",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationTrainedModelInput, options: Options) !GetCollaborationTrainedModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cleanroomsml");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetCollaborationTrainedModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanroomsml", "CleanRoomsML", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/collaborations/");
    try path_buf.appendSlice(alloc, input.collaboration_identifier);
    try path_buf.appendSlice(alloc, "/trained-models/");
    try path_buf.appendSlice(alloc, input.trained_model_arn);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.version_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "versionIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetCollaborationTrainedModelOutput {
    var result: GetCollaborationTrainedModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCollaborationTrainedModelOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
