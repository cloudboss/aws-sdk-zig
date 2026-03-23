const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlgorithmSpecification = @import("algorithm_specification.zig").AlgorithmSpecification;
const Association = @import("association.zig").Association;
const JobCheckpointConfig = @import("job_checkpoint_config.zig").JobCheckpointConfig;
const DeviceConfig = @import("device_config.zig").DeviceConfig;
const InputFileConfig = @import("input_file_config.zig").InputFileConfig;
const InstanceConfig = @import("instance_config.zig").InstanceConfig;
const JobOutputDataConfig = @import("job_output_data_config.zig").JobOutputDataConfig;
const JobStoppingCondition = @import("job_stopping_condition.zig").JobStoppingCondition;

pub const CreateJobInput = struct {
    /// Definition of the Amazon Braket job to be created. Specifies the container
    /// image the job uses and information about the Python scripts used for entry
    /// and training.
    algorithm_specification: AlgorithmSpecification,

    /// The list of Amazon Braket resources associated with the hybrid job.
    associations: ?[]const Association = null,

    /// Information about the output locations for hybrid job checkpoint data.
    checkpoint_config: ?JobCheckpointConfig = null,

    /// The client token associated with this request that guarantees that the
    /// request is idempotent.
    client_token: []const u8,

    /// The quantum processing unit (QPU) or simulator used to create an Amazon
    /// Braket hybrid job.
    device_config: DeviceConfig,

    /// Algorithm-specific parameters used by an Amazon Braket hybrid job that
    /// influence the quality of the training job. The values are set with a map of
    /// JSON key:value pairs, where the key is the name of the hyperparameter and
    /// the value is the value of the hyperparameter.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any hyperparameter fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by
    /// security-sensitive information included in the request hyperparameter
    /// variable or plain text fields.
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// A list of parameters that specify the name and type of input data and where
    /// it is located.
    input_data_config: ?[]const InputFileConfig = null,

    /// Configuration of the resource instances to use while running the hybrid job
    /// on Amazon Braket.
    instance_config: InstanceConfig,

    /// The name of the Amazon Braket hybrid job.
    job_name: []const u8,

    /// The path to the S3 location where you want to store hybrid job artifacts and
    /// the encryption key used to store them.
    output_data_config: JobOutputDataConfig,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon Braket can assume
    /// to perform tasks on behalf of a user. It can access user resources, run an
    /// Amazon Braket job container on behalf of user, and output results and hybrid
    /// job details to the users' s3 buckets.
    role_arn: []const u8,

    /// The user-defined criteria that specifies when a hybrid job stops running.
    stopping_condition: ?JobStoppingCondition = null,

    /// Tags to be added to the hybrid job you're creating.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .algorithm_specification = "algorithmSpecification",
        .associations = "associations",
        .checkpoint_config = "checkpointConfig",
        .client_token = "clientToken",
        .device_config = "deviceConfig",
        .hyper_parameters = "hyperParameters",
        .input_data_config = "inputDataConfig",
        .instance_config = "instanceConfig",
        .job_name = "jobName",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
        .stopping_condition = "stoppingCondition",
        .tags = "tags",
    };
};

pub const CreateJobOutput = struct {
    /// The ARN of the Amazon Braket hybrid job created.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: CallOptions) !CreateJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/job";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"algorithmSpecification\":");
    try aws.json.writeValue(@TypeOf(input.algorithm_specification), input.algorithm_specification, allocator, &body_buf);
    has_prev = true;
    if (input.associations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.checkpoint_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checkpointConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deviceConfig\":");
    try aws.json.writeValue(@TypeOf(input.device_config), input.device_config, allocator, &body_buf);
    has_prev = true;
    if (input.hyper_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hyperParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_data_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputDataConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instanceConfig\":");
    try aws.json.writeValue(@TypeOf(input.instance_config), input.instance_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_data_config), input.output_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.stopping_condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stoppingCondition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobOutput {
    var result: CreateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobOutput, body, allocator);
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
