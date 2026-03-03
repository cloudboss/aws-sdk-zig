const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataQualityAppSpecification = @import("data_quality_app_specification.zig").DataQualityAppSpecification;
const DataQualityBaselineConfig = @import("data_quality_baseline_config.zig").DataQualityBaselineConfig;
const DataQualityJobInput = @import("data_quality_job_input.zig").DataQualityJobInput;
const MonitoringOutputConfig = @import("monitoring_output_config.zig").MonitoringOutputConfig;
const MonitoringResources = @import("monitoring_resources.zig").MonitoringResources;
const MonitoringNetworkConfig = @import("monitoring_network_config.zig").MonitoringNetworkConfig;
const MonitoringStoppingCondition = @import("monitoring_stopping_condition.zig").MonitoringStoppingCondition;
const Tag = @import("tag.zig").Tag;

pub const CreateDataQualityJobDefinitionInput = struct {
    /// Specifies the container that runs the monitoring job.
    data_quality_app_specification: DataQualityAppSpecification,

    /// Configures the constraints and baselines for the monitoring job.
    data_quality_baseline_config: ?DataQualityBaselineConfig = null,

    /// A list of inputs for the monitoring job. Currently endpoints are supported
    /// as monitoring inputs.
    data_quality_job_input: DataQualityJobInput,

    data_quality_job_output_config: MonitoringOutputConfig,

    /// The name for the monitoring job definition.
    job_definition_name: []const u8,

    job_resources: MonitoringResources,

    /// Specifies networking configuration for the monitoring job.
    network_config: ?MonitoringNetworkConfig = null,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker AI can
    /// assume to perform tasks on your behalf.
    role_arn: []const u8,

    stopping_condition: ?MonitoringStoppingCondition = null,

    /// (Optional) An array of key-value pairs. For more information, see [ Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-whatURL) in the *Amazon Web Services Billing and Cost Management User Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .data_quality_app_specification = "DataQualityAppSpecification",
        .data_quality_baseline_config = "DataQualityBaselineConfig",
        .data_quality_job_input = "DataQualityJobInput",
        .data_quality_job_output_config = "DataQualityJobOutputConfig",
        .job_definition_name = "JobDefinitionName",
        .job_resources = "JobResources",
        .network_config = "NetworkConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
    };
};

pub const CreateDataQualityJobDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the job definition.
    job_definition_arn: []const u8,

    pub const json_field_names = .{
        .job_definition_arn = "JobDefinitionArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataQualityJobDefinitionInput, options: Options) !CreateDataQualityJobDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataQualityJobDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateDataQualityJobDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataQualityJobDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateDataQualityJobDefinitionOutput, body, allocator);
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
