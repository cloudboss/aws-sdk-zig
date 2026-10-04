const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelBiasJobDefinitionInput, options: CallOptions) !DescribeModelBiasJobDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelBiasJobDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModelBiasJobDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelBiasJobDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelBiasJobDefinitionOutput, body, allocator);
}
