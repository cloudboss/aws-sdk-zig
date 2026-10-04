const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Code = @import("code.zig").Code;
const DefinitionS3Location = @import("definition_s3_location.zig").DefinitionS3Location;
const EngineVersion = @import("engine_version.zig").EngineVersion;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;

pub const UpdateWorkflowInput = struct {
    /// The location of code artifacts in Amazon S3 for the updated workflow. The
    /// service copies the code from this location at the time of the request.
    code: ?Code = null,

    /// The Amazon S3 location where the updated workflow definition file is stored.
    definition_s3_location: DefinitionS3Location,

    /// An updated description for the workflow.
    description: ?[]const u8 = null,

    /// The version of the Amazon Managed Workflows for Apache Airflow Serverless
    /// engine that you want to use for the updated workflow.
    engine_version: ?EngineVersion = null,

    /// Updated logging configuration for the workflow.
    logging_configuration: ?LoggingConfiguration = null,

    /// Updated network configuration for the workflow execution environment.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon Managed Workflows
    /// for Apache Airflow Serverless assumes when it executes the updated workflow.
    role_arn: []const u8,

    /// The trigger mode for the workflow execution.
    trigger_mode: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow you want to update.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .definition_s3_location = "DefinitionS3Location",
        .description = "Description",
        .engine_version = "EngineVersion",
        .logging_configuration = "LoggingConfiguration",
        .network_configuration = "NetworkConfiguration",
        .role_arn = "RoleArn",
        .trigger_mode = "TriggerMode",
        .workflow_arn = "WorkflowArn",
    };
};

pub const UpdateWorkflowOutput = struct {
    /// The timestamp when the workflow was last modified, in ISO 8601 date-time
    /// format.
    modified_at: ?i64 = null,

    /// Warning messages generated during workflow update.
    warnings: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the updated workflow.
    workflow_arn: []const u8,

    /// The version identifier of the updated workflow.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .modified_at = "ModifiedAt",
        .warnings = "Warnings",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkflowInput, options: CallOptions) !UpdateWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow-serverless", "MWAA Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.UpdateWorkflow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkflowOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWorkflowOutput, body, allocator);
}
