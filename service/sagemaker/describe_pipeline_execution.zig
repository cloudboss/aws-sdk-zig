const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const MLflowConfiguration = @import("m_lflow_configuration.zig").MLflowConfiguration;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;
const PipelineExperimentConfig = @import("pipeline_experiment_config.zig").PipelineExperimentConfig;
const SelectiveExecutionConfig = @import("selective_execution_config.zig").SelectiveExecutionConfig;

pub const DescribePipelineExecutionInput = struct {
    /// The Amazon Resource Name (ARN) of the pipeline execution.
    pipeline_execution_arn: []const u8,

    pub const json_field_names = .{
        .pipeline_execution_arn = "PipelineExecutionArn",
    };
};

pub const DescribePipelineExecutionOutput = struct {
    created_by: ?UserContext = null,

    /// The time when the pipeline execution was created.
    creation_time: ?i64 = null,

    /// If the execution failed, a message describing why.
    failure_reason: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// The time when the pipeline execution was modified last.
    last_modified_time: ?i64 = null,

    /// The MLflow configuration of the pipeline execution.
    m_lflow_config: ?MLflowConfiguration = null,

    /// The parallelism configuration applied to the pipeline.
    parallelism_configuration: ?ParallelismConfiguration = null,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline execution.
    pipeline_execution_arn: ?[]const u8 = null,

    /// The description of the pipeline execution.
    pipeline_execution_description: ?[]const u8 = null,

    /// The display name of the pipeline execution.
    pipeline_execution_display_name: ?[]const u8 = null,

    /// The status of the pipeline execution.
    pipeline_execution_status: ?PipelineExecutionStatus = null,

    pipeline_experiment_config: ?PipelineExperimentConfig = null,

    /// The ID of the pipeline version.
    pipeline_version_id: ?i64 = null,

    /// The selective execution configuration applied to the pipeline run.
    selective_execution_config: ?SelectiveExecutionConfig = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .m_lflow_config = "MLflowConfig",
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_arn = "PipelineArn",
        .pipeline_execution_arn = "PipelineExecutionArn",
        .pipeline_execution_description = "PipelineExecutionDescription",
        .pipeline_execution_display_name = "PipelineExecutionDisplayName",
        .pipeline_execution_status = "PipelineExecutionStatus",
        .pipeline_experiment_config = "PipelineExperimentConfig",
        .pipeline_version_id = "PipelineVersionId",
        .selective_execution_config = "SelectiveExecutionConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePipelineExecutionInput, options: CallOptions) !DescribePipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePipelineExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribePipelineExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePipelineExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePipelineExecutionOutput, body, allocator);
}
