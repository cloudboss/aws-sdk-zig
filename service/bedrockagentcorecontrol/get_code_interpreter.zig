const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const ToolsFileSystemConfiguration = @import("tools_file_system_configuration.zig").ToolsFileSystemConfiguration;
const CodeInterpreterNetworkConfiguration = @import("code_interpreter_network_configuration.zig").CodeInterpreterNetworkConfiguration;
const CodeInterpreterStatus = @import("code_interpreter_status.zig").CodeInterpreterStatus;

pub const GetCodeInterpreterInput = struct {
    /// The unique identifier of the code interpreter to retrieve.
    code_interpreter_id: []const u8,

    pub const json_field_names = .{
        .code_interpreter_id = "codeInterpreterId",
    };
};

pub const GetCodeInterpreterOutput = struct {
    /// The list of certificates configured for the code interpreter.
    certificates: ?[]const Certificate = null,

    /// The Amazon Resource Name (ARN) of the code interpreter.
    code_interpreter_arn: []const u8,

    /// The unique identifier of the code interpreter.
    code_interpreter_id: []const u8,

    /// The timestamp when the code interpreter was created.
    created_at: i64,

    /// The description of the code interpreter.
    description: ?[]const u8 = null,

    /// The IAM role ARN that provides permissions for the code interpreter.
    execution_role_arn: ?[]const u8 = null,

    /// The reason for failure if the code interpreter is in a failed state.
    failure_reason: ?[]const u8 = null,

    /// The file system configurations mounted into the code interpreter. Each entry
    /// describes an access point and its mount path.
    filesystem_configurations: ?[]const ToolsFileSystemConfiguration = null,

    /// The timestamp when the code interpreter was last updated.
    last_updated_at: i64,

    /// The name of the code interpreter.
    name: []const u8,

    network_configuration: ?CodeInterpreterNetworkConfiguration = null,

    /// The current status of the code interpreter.
    status: CodeInterpreterStatus,

    pub const json_field_names = .{
        .certificates = "certificates",
        .code_interpreter_arn = "codeInterpreterArn",
        .code_interpreter_id = "codeInterpreterId",
        .created_at = "createdAt",
        .description = "description",
        .execution_role_arn = "executionRoleArn",
        .failure_reason = "failureReason",
        .filesystem_configurations = "filesystemConfigurations",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCodeInterpreterInput, options: CallOptions) !GetCodeInterpreterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCodeInterpreterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/code-interpreters/");
    try path_buf.appendSlice(allocator, input.code_interpreter_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCodeInterpreterOutput {
    const result: GetCodeInterpreterOutput = try aws.json.parseJsonObject(
        GetCodeInterpreterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
