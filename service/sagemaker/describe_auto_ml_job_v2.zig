const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoMLComputeConfig = @import("auto_ml_compute_config.zig").AutoMLComputeConfig;
const AutoMLJobArtifacts = @import("auto_ml_job_artifacts.zig").AutoMLJobArtifacts;
const AutoMLJobChannel = @import("auto_ml_job_channel.zig").AutoMLJobChannel;
const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLJobSecondaryStatus = @import("auto_ml_job_secondary_status.zig").AutoMLJobSecondaryStatus;
const AutoMLJobStatus = @import("auto_ml_job_status.zig").AutoMLJobStatus;
const AutoMLProblemTypeConfig = @import("auto_ml_problem_type_config.zig").AutoMLProblemTypeConfig;
const AutoMLProblemTypeConfigName = @import("auto_ml_problem_type_config_name.zig").AutoMLProblemTypeConfigName;
const AutoMLCandidate = @import("auto_ml_candidate.zig").AutoMLCandidate;
const AutoMLDataSplitConfig = @import("auto_ml_data_split_config.zig").AutoMLDataSplitConfig;
const ModelDeployConfig = @import("model_deploy_config.zig").ModelDeployConfig;
const ModelDeployResult = @import("model_deploy_result.zig").ModelDeployResult;
const AutoMLOutputDataConfig = @import("auto_ml_output_data_config.zig").AutoMLOutputDataConfig;
const AutoMLPartialFailureReason = @import("auto_ml_partial_failure_reason.zig").AutoMLPartialFailureReason;
const AutoMLResolvedAttributes = @import("auto_ml_resolved_attributes.zig").AutoMLResolvedAttributes;
const AutoMLSecurityConfig = @import("auto_ml_security_config.zig").AutoMLSecurityConfig;

pub const DescribeAutoMLJobV2Input = struct {
    /// Requests information about an AutoML job V2 using its unique name.
    auto_ml_job_name: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_name = "AutoMLJobName",
    };
};

pub const DescribeAutoMLJobV2Output = struct {
    /// The compute configuration used for the AutoML job V2.
    auto_ml_compute_config: ?AutoMLComputeConfig = null,

    /// Returns the Amazon Resource Name (ARN) of the AutoML job V2.
    auto_ml_job_arn: []const u8,

    auto_ml_job_artifacts: ?AutoMLJobArtifacts = null,

    /// Returns an array of channel objects describing the input data and their
    /// location.
    auto_ml_job_input_data_config: ?[]const AutoMLJobChannel = null,

    /// Returns the name of the AutoML job V2.
    auto_ml_job_name: []const u8,

    /// Returns the job's objective.
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    /// Returns the secondary status of the AutoML job V2.
    auto_ml_job_secondary_status: AutoMLJobSecondaryStatus,

    /// Returns the status of the AutoML job V2.
    auto_ml_job_status: AutoMLJobStatus,

    /// Returns the configuration settings of the problem type set for the AutoML
    /// job V2.
    auto_ml_problem_type_config: ?AutoMLProblemTypeConfig = null,

    /// Returns the name of the problem type configuration set for the AutoML job
    /// V2.
    auto_ml_problem_type_config_name: ?AutoMLProblemTypeConfigName = null,

    /// Information about the candidate produced by an AutoML training job V2,
    /// including its status, steps, and other properties.
    best_candidate: ?AutoMLCandidate = null,

    /// Returns the creation time of the AutoML job V2.
    creation_time: i64,

    /// Returns the configuration settings of how the data are split into train and
    /// validation datasets.
    data_split_config: ?AutoMLDataSplitConfig = null,

    /// Returns the end time of the AutoML job V2.
    end_time: ?i64 = null,

    /// Returns the reason for the failure of the AutoML job V2, when applicable.
    failure_reason: ?[]const u8 = null,

    /// Returns the job's last modified time.
    last_modified_time: i64,

    /// Indicates whether the model was deployed automatically to an endpoint and
    /// the name of that endpoint if deployed automatically.
    model_deploy_config: ?ModelDeployConfig = null,

    /// Provides information about endpoint for the model deployment.
    model_deploy_result: ?ModelDeployResult = null,

    /// Returns the job's output data config.
    output_data_config: ?AutoMLOutputDataConfig = null,

    /// Returns a list of reasons for partial failures within an AutoML job V2.
    partial_failure_reasons: ?[]const AutoMLPartialFailureReason = null,

    /// Returns the resolved attributes used by the AutoML job V2.
    resolved_attributes: ?AutoMLResolvedAttributes = null,

    /// The ARN of the IAM role that has read permission to the input data location
    /// and write permission to the output data location in Amazon S3.
    role_arn: []const u8,

    /// Returns the security configuration for traffic encryption or Amazon VPC
    /// settings.
    security_config: ?AutoMLSecurityConfig = null,

    pub const json_field_names = .{
        .auto_ml_compute_config = "AutoMLComputeConfig",
        .auto_ml_job_arn = "AutoMLJobArn",
        .auto_ml_job_artifacts = "AutoMLJobArtifacts",
        .auto_ml_job_input_data_config = "AutoMLJobInputDataConfig",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_objective = "AutoMLJobObjective",
        .auto_ml_job_secondary_status = "AutoMLJobSecondaryStatus",
        .auto_ml_job_status = "AutoMLJobStatus",
        .auto_ml_problem_type_config = "AutoMLProblemTypeConfig",
        .auto_ml_problem_type_config_name = "AutoMLProblemTypeConfigName",
        .best_candidate = "BestCandidate",
        .creation_time = "CreationTime",
        .data_split_config = "DataSplitConfig",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .model_deploy_config = "ModelDeployConfig",
        .model_deploy_result = "ModelDeployResult",
        .output_data_config = "OutputDataConfig",
        .partial_failure_reasons = "PartialFailureReasons",
        .resolved_attributes = "ResolvedAttributes",
        .role_arn = "RoleArn",
        .security_config = "SecurityConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAutoMLJobV2Input, options: CallOptions) !DescribeAutoMLJobV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAutoMLJobV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeAutoMLJobV2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAutoMLJobV2Output {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAutoMLJobV2Output, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
