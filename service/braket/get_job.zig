const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HybridJobAdditionalAttributeName = @import("hybrid_job_additional_attribute_name.zig").HybridJobAdditionalAttributeName;
const AlgorithmSpecification = @import("algorithm_specification.zig").AlgorithmSpecification;
const Association = @import("association.zig").Association;
const JobCheckpointConfig = @import("job_checkpoint_config.zig").JobCheckpointConfig;
const DeviceConfig = @import("device_config.zig").DeviceConfig;
const JobEventDetails = @import("job_event_details.zig").JobEventDetails;
const InputFileConfig = @import("input_file_config.zig").InputFileConfig;
const InstanceConfig = @import("instance_config.zig").InstanceConfig;
const JobOutputDataConfig = @import("job_output_data_config.zig").JobOutputDataConfig;
const HybridJobQueueInfo = @import("hybrid_job_queue_info.zig").HybridJobQueueInfo;
const JobPrimaryStatus = @import("job_primary_status.zig").JobPrimaryStatus;
const JobStoppingCondition = @import("job_stopping_condition.zig").JobStoppingCondition;

pub const GetJobInput = struct {
    /// A list of attributes to return additional information for. Only the
    /// QueueInfo additional attribute name is currently supported.
    additional_attribute_names: ?[]const HybridJobAdditionalAttributeName = null,

    /// The ARN of the hybrid job to retrieve.
    job_arn: []const u8,

    pub const json_field_names = .{
        .additional_attribute_names = "additionalAttributeNames",
        .job_arn = "jobArn",
    };
};

pub const GetJobOutput = struct {
    /// Definition of the Amazon Braket hybrid job created. Provides information
    /// about the container image used, and the Python scripts used for training.
    algorithm_specification: ?AlgorithmSpecification = null,

    /// The list of Amazon Braket resources associated with the hybrid job.
    associations: ?[]const Association = null,

    /// The billable time for which the Amazon Braket hybrid job used to complete.
    billable_duration: ?i32 = null,

    /// Information about the output locations for hybrid job checkpoint data.
    checkpoint_config: ?JobCheckpointConfig = null,

    /// The time at which the Amazon Braket hybrid job was created.
    created_at: i64,

    /// The primary device used by the Amazon Braket hybrid job.
    device_config: ?DeviceConfig = null,

    /// The time at which the Amazon Braket hybrid job ended.
    ended_at: ?i64 = null,

    /// Details about the time and type of events occurred related to the Amazon
    /// Braket hybrid job.
    events: ?[]const JobEventDetails = null,

    /// A description of the reason why an Amazon Braket hybrid job failed, if it
    /// failed.
    failure_reason: ?[]const u8 = null,

    /// Algorithm-specific parameters used by an Amazon Braket hybrid job that
    /// influence the quality of the traiing job. The values are set with a map of
    /// JSON key:value pairs, where the key is the name of the hyperparameter and
    /// the value is the value of th hyperparameter.
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// A list of parameters that specify the name and type of input data and where
    /// it is located.
    input_data_config: ?[]const InputFileConfig = null,

    /// The resource instances to use while running the hybrid job on Amazon Braket.
    instance_config: ?InstanceConfig = null,

    /// The ARN of the Amazon Braket hybrid job.
    job_arn: []const u8,

    /// The name of the Amazon Braket hybrid job.
    job_name: []const u8,

    /// The path to the S3 location where hybrid job artifacts are stored and the
    /// encryption key used to store them there.
    output_data_config: ?JobOutputDataConfig = null,

    /// Queue information for the requested hybrid job. Only returned if `QueueInfo`
    /// is specified in the `additionalAttributeNames"` field in the `GetJob` API
    /// request.
    queue_info: ?HybridJobQueueInfo = null,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon Braket can assume
    /// to perform tasks on behalf of a user. It can access user resources, run an
    /// Amazon Braket job container on behalf of user, and output results and other
    /// hybrid job details to the s3 buckets of a user.
    role_arn: []const u8,

    /// The time at which the Amazon Braket hybrid job was started.
    started_at: ?i64 = null,

    /// The status of the Amazon Braket hybrid job.
    status: JobPrimaryStatus,

    /// The user-defined criteria that specifies when to stop a running hybrid job.
    stopping_condition: ?JobStoppingCondition = null,

    /// The tags associated with this hybrid job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .algorithm_specification = "algorithmSpecification",
        .associations = "associations",
        .billable_duration = "billableDuration",
        .checkpoint_config = "checkpointConfig",
        .created_at = "createdAt",
        .device_config = "deviceConfig",
        .ended_at = "endedAt",
        .events = "events",
        .failure_reason = "failureReason",
        .hyper_parameters = "hyperParameters",
        .input_data_config = "inputDataConfig",
        .instance_config = "instanceConfig",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .output_data_config = "outputDataConfig",
        .queue_info = "queueInfo",
        .role_arn = "roleArn",
        .started_at = "startedAt",
        .status = "status",
        .stopping_condition = "stoppingCondition",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobInput, options: CallOptions) !GetJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "braket");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/job/");
    try path_buf.appendSlice(allocator, input.job_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.additional_attribute_names) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "additionalAttributeNames=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobOutput {
    var result: GetJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetJobOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DeviceOfflineException")) {
        return .{ .arena = arena, .kind = .{ .device_offline_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeviceRetiredException")) {
        return .{ .arena = arena, .kind = .{ .device_retired_exception = .{
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
