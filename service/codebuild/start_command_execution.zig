const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandType = @import("command_type.zig").CommandType;
const CommandExecution = @import("command_execution.zig").CommandExecution;

pub const StartCommandExecutionInput = struct {
    /// The command that needs to be executed.
    command: []const u8,

    /// A `sandboxId` or `sandboxArn`.
    sandbox_id: []const u8,

    /// The command type.
    @"type": ?CommandType = null,

    pub const json_field_names = .{
        .command = "command",
        .sandbox_id = "sandboxId",
        .@"type" = "type",
    };
};

pub const StartCommandExecutionOutput = struct {
    /// Information about the requested command executions.
    command_execution: ?CommandExecution = null,

    pub const json_field_names = .{
        .command_execution = "commandExecution",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCommandExecutionInput, options: CallOptions) !StartCommandExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCommandExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.StartCommandExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCommandExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartCommandExecutionOutput, body, allocator);
}
