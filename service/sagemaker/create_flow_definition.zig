const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowDefinitionInput, options: Options) !CreateFlowDefinitionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFlowDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateFlowDefinition");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFlowDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFlowDefinitionOutput, body, alloc);
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
