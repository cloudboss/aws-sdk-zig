const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitoringResources = @import("monitoring_resources.zig").MonitoringResources;
const ModelQualityAppSpecification = @import("model_quality_app_specification.zig").ModelQualityAppSpecification;
const ModelQualityBaselineConfig = @import("model_quality_baseline_config.zig").ModelQualityBaselineConfig;
const ModelQualityJobInput = @import("model_quality_job_input.zig").ModelQualityJobInput;
const MonitoringOutputConfig = @import("monitoring_output_config.zig").MonitoringOutputConfig;
const MonitoringNetworkConfig = @import("monitoring_network_config.zig").MonitoringNetworkConfig;
const MonitoringStoppingCondition = @import("monitoring_stopping_condition.zig").MonitoringStoppingCondition;
const Tag = @import("tag.zig").Tag;

pub const CreateModelQualityJobDefinitionInput = struct {
    /// The name of the monitoring job definition.
    job_definition_name: []const u8,

    job_resources: MonitoringResources,

    /// The container that runs the monitoring job.
    model_quality_app_specification: ModelQualityAppSpecification,

    /// Specifies the constraints and baselines for the monitoring job.
    model_quality_baseline_config: ?ModelQualityBaselineConfig = null,

    /// A list of the inputs that are monitored. Currently endpoints are supported.
    model_quality_job_input: ModelQualityJobInput,

    model_quality_job_output_config: MonitoringOutputConfig,

    /// Specifies the network configuration for the monitoring job.
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
        .job_definition_name = "JobDefinitionName",
        .job_resources = "JobResources",
        .model_quality_app_specification = "ModelQualityAppSpecification",
        .model_quality_baseline_config = "ModelQualityBaselineConfig",
        .model_quality_job_input = "ModelQualityJobInput",
        .model_quality_job_output_config = "ModelQualityJobOutputConfig",
        .network_config = "NetworkConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
    };
};

pub const CreateModelQualityJobDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the model quality monitoring job.
    job_definition_arn: []const u8,

    pub const json_field_names = .{
        .job_definition_arn = "JobDefinitionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelQualityJobDefinitionInput, options: CallOptions) !CreateModelQualityJobDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelQualityJobDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateModelQualityJobDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelQualityJobDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateModelQualityJobDefinitionOutput, body, allocator);
}
