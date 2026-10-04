const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HumanLoopActivationConfig = @import("human_loop_activation_config.zig").HumanLoopActivationConfig;
const HumanLoopConfig = @import("human_loop_config.zig").HumanLoopConfig;
const HumanLoopRequestSource = @import("human_loop_request_source.zig").HumanLoopRequestSource;
const FlowDefinitionOutputConfig = @import("flow_definition_output_config.zig").FlowDefinitionOutputConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateFlowDefinitionInput = struct {
    /// The name of your flow definition.
    flow_definition_name: []const u8,

    /// An object containing information about the events that trigger a human
    /// workflow.
    human_loop_activation_config: ?HumanLoopActivationConfig = null,

    /// An object containing information about the tasks the human reviewers will
    /// perform.
    human_loop_config: ?HumanLoopConfig = null,

    /// Container for configuring the source of human task requests. Use to specify
    /// if Amazon Rekognition or Amazon Textract is used as an integration source.
    human_loop_request_source: ?HumanLoopRequestSource = null,

    /// An object containing information about where the human review results will
    /// be uploaded.
    output_config: FlowDefinitionOutputConfig,

    /// The Amazon Resource Name (ARN) of the role needed to call other services on
    /// your behalf. For example,
    /// `arn:aws:iam::1234567890:role/service-role/AmazonSageMaker-ExecutionRole-20180111T151298`.
    role_arn: []const u8,

    /// An array of key-value pairs that contain metadata to help you categorize and
    /// organize a flow definition. Each tag consists of a key and a value, both of
    /// which you define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .flow_definition_name = "FlowDefinitionName",
        .human_loop_activation_config = "HumanLoopActivationConfig",
        .human_loop_config = "HumanLoopConfig",
        .human_loop_request_source = "HumanLoopRequestSource",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateFlowDefinitionOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow definition you create.
    flow_definition_arn: []const u8,

    pub const json_field_names = .{
        .flow_definition_arn = "FlowDefinitionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowDefinitionInput, options: CallOptions) !CreateFlowDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateFlowDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFlowDefinitionOutput, body, allocator);
}
