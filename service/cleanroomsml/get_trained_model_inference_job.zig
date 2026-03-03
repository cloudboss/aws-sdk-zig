const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceContainerExecutionParameters = @import("inference_container_execution_parameters.zig").InferenceContainerExecutionParameters;
const ModelInferenceDataSource = @import("model_inference_data_source.zig").ModelInferenceDataSource;
const LogsStatus = @import("logs_status.zig").LogsStatus;
const MetricsStatus = @import("metrics_status.zig").MetricsStatus;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const InferenceResourceConfig = @import("inference_resource_config.zig").InferenceResourceConfig;
const TrainedModelInferenceJobStatus = @import("trained_model_inference_job_status.zig").TrainedModelInferenceJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

pub const GetTrainedModelInferenceJobInput = struct {
    /// Provides the membership ID of the membership that contains the trained model
    /// inference job that you are interested in.
    membership_identifier: []const u8,

    /// Provides the Amazon Resource Name (ARN) of the trained model inference job
    /// that you are interested in.
    trained_model_inference_job_arn: []const u8,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .trained_model_inference_job_arn = "trainedModelInferenceJobArn",
    };
};

pub const GetTrainedModelInferenceJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the configured model algorithm association
    /// that was used for the trained model inference job.
    configured_model_algorithm_association_arn: ?[]const u8 = null,

    /// The execution parameters for the model inference job container.
    container_execution_parameters: ?InferenceContainerExecutionParameters = null,

    /// The time at which the trained model inference job was created.
    create_time: i64,

    /// The data source that was used for the trained model inference job.
    data_source: ?ModelInferenceDataSource = null,

    /// The description of the trained model inference job.
    description: ?[]const u8 = null,

    /// The environment variables to set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// Information about the training container image.
    inference_container_image_digest: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key. This key is used to encrypt
    /// and decrypt customer-owned data in the ML inference job and associated data.
    kms_key_arn: ?[]const u8 = null,

    /// The logs status for the trained model inference job.
    logs_status: ?LogsStatus = null,

    /// Details about the logs status for the trained model inference job.
    logs_status_details: ?[]const u8 = null,

    /// The membership ID of the membership that contains the trained model
    /// inference job.
    membership_identifier: []const u8,

    /// The metrics status for the trained model inference job.
    metrics_status: ?MetricsStatus = null,

    /// Details about the metrics status for the trained model inference job.
    metrics_status_details: ?[]const u8 = null,

    /// The name of the trained model inference job.
    name: []const u8,

    /// The output configuration information for the trained model inference job.
    output_configuration: ?InferenceOutputConfiguration = null,

    /// The resource configuration information for the trained model inference job.
    resource_config: ?InferenceResourceConfig = null,

    /// The status of the trained model inference job.
    status: TrainedModelInferenceJobStatus,

    status_details: ?StatusDetails = null,

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

    /// The Amazon Resource Name (ARN) for the trained model that was used for the
    /// trained model inference job.
    trained_model_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model inference job.
    trained_model_inference_job_arn: []const u8,

    /// The version identifier of the trained model used for this inference job.
    /// This identifies the specific version of the trained model that was used to
    /// generate the inference results.
    trained_model_version_identifier: ?[]const u8 = null,

    /// The most recent time at which the trained model inference job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .configured_model_algorithm_association_arn = "configuredModelAlgorithmAssociationArn",
        .container_execution_parameters = "containerExecutionParameters",
        .create_time = "createTime",
        .data_source = "dataSource",
        .description = "description",
        .environment = "environment",
        .inference_container_image_digest = "inferenceContainerImageDigest",
        .kms_key_arn = "kmsKeyArn",
        .logs_status = "logsStatus",
        .logs_status_details = "logsStatusDetails",
        .membership_identifier = "membershipIdentifier",
        .metrics_status = "metricsStatus",
        .metrics_status_details = "metricsStatusDetails",
        .name = "name",
        .output_configuration = "outputConfiguration",
        .resource_config = "resourceConfig",
        .status = "status",
        .status_details = "statusDetails",
        .tags = "tags",
        .trained_model_arn = "trainedModelArn",
        .trained_model_inference_job_arn = "trainedModelInferenceJobArn",
        .trained_model_version_identifier = "trainedModelVersionIdentifier",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrainedModelInferenceJobInput, options: CallOptions) !GetTrainedModelInferenceJobOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrainedModelInferenceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanroomsml", "CleanRoomsML", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-model-inference-jobs/");
    try path_buf.appendSlice(allocator, input.trained_model_inference_job_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrainedModelInferenceJobOutput {
    var result: GetTrainedModelInferenceJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTrainedModelInferenceJobOutput, body, allocator);
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
