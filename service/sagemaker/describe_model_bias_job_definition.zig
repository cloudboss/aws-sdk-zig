const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MonitoringResources = @import("monitoring_resources.zig").MonitoringResources;
const ModelBiasAppSpecification = @import("model_bias_app_specification.zig").ModelBiasAppSpecification;
const ModelBiasBaselineConfig = @import("model_bias_baseline_config.zig").ModelBiasBaselineConfig;
const ModelBiasJobInput = @import("model_bias_job_input.zig").ModelBiasJobInput;
const MonitoringOutputConfig = @import("monitoring_output_config.zig").MonitoringOutputConfig;
const MonitoringNetworkConfig = @import("monitoring_network_config.zig").MonitoringNetworkConfig;
const MonitoringStoppingCondition = @import("monitoring_stopping_condition.zig").MonitoringStoppingCondition;

pub const DescribeModelBiasJobDefinitionInput = struct {
    /// The name of the model bias job definition. The name must be unique within an
    /// Amazon Web Services Region in the Amazon Web Services account.
    job_definition_name: []const u8,

    pub const json_field_names = .{
        .job_definition_name = "JobDefinitionName",
    };
};

pub const DescribeModelBiasJobDefinitionOutput = struct {
    /// The time at which the model bias job was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the model bias job.
    job_definition_arn: []const u8,

    /// The name of the bias job definition. The name must be unique within an
    /// Amazon Web Services Region in the Amazon Web Services account.
    job_definition_name: []const u8,

    job_resources: ?MonitoringResources = null,

    /// Configures the model bias job to run a specified Docker container image.
    model_bias_app_specification: ?ModelBiasAppSpecification = null,

    /// The baseline configuration for a model bias job.
    model_bias_baseline_config: ?ModelBiasBaselineConfig = null,

    /// Inputs for the model bias job.
    model_bias_job_input: ?ModelBiasJobInput = null,

    model_bias_job_output_config: ?MonitoringOutputConfig = null,

    /// Networking options for a model bias job.
    network_config: ?MonitoringNetworkConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM role that has read permission to
    /// the input data location and write permission to the output data location in
    /// Amazon S3.
    role_arn: []const u8,

    stopping_condition: ?MonitoringStoppingCondition = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .job_definition_arn = "JobDefinitionArn",
        .job_definition_name = "JobDefinitionName",
        .job_resources = "JobResources",
        .model_bias_app_specification = "ModelBiasAppSpecification",
        .model_bias_baseline_config = "ModelBiasBaselineConfig",
        .model_bias_job_input = "ModelBiasJobInput",
        .model_bias_job_output_config = "ModelBiasJobOutputConfig",
        .network_config = "NetworkConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelBiasJobDefinitionInput, options: Options) !DescribeModelBiasJobDefinitionOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeModelBiasJobDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeModelBiasJobDefinition");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeModelBiasJobDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeModelBiasJobDefinitionOutput, body, alloc);
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
