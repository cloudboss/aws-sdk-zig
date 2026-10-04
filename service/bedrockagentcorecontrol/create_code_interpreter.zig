const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const CodeInterpreterNetworkConfiguration = @import("code_interpreter_network_configuration.zig").CodeInterpreterNetworkConfiguration;
const CodeInterpreterStatus = @import("code_interpreter_status.zig").CodeInterpreterStatus;

pub const CreateCodeInterpreterInput = struct {
    /// A list of certificates to install in the code interpreter.
    certificates: ?[]const Certificate = null,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock AgentCore ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// The description of the code interpreter.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the code interpreter to access Amazon Web Services services.
    execution_role_arn: ?[]const u8 = null,

    /// The name of the code interpreter. The name must be unique within your
    /// account.
    name: []const u8,

    /// The network configuration for the code interpreter. This configuration
    /// specifies the network mode for the code interpreter.
    network_configuration: CodeInterpreterNetworkConfiguration,

    /// A map of tag keys and values to assign to the code interpreter. Tags enable
    /// you to categorize your resources in different ways, for example, by purpose,
    /// owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .certificates = "certificates",
        .client_token = "clientToken",
        .description = "description",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .tags = "tags",
    };
};

pub const CreateCodeInterpreterOutput = struct {
    /// The Amazon Resource Name (ARN) of the created code interpreter.
    code_interpreter_arn: []const u8,

    /// The unique identifier of the created code interpreter.
    code_interpreter_id: []const u8,

    /// The timestamp when the code interpreter was created.
    created_at: i64,

    /// The current status of the code interpreter.
    status: CodeInterpreterStatus,

    pub const json_field_names = .{
        .code_interpreter_arn = "codeInterpreterArn",
        .code_interpreter_id = "codeInterpreterId",
        .created_at = "createdAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCodeInterpreterInput, options: CallOptions) !CreateCodeInterpreterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCodeInterpreterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/code-interpreters";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.network_configuration), input.network_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCodeInterpreterOutput {
    var result: CreateCodeInterpreterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCodeInterpreterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
