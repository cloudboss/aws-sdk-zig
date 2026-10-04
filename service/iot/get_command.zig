const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommandParameter = @import("command_parameter.zig").CommandParameter;
const CommandNamespace = @import("command_namespace.zig").CommandNamespace;
const CommandPayload = @import("command_payload.zig").CommandPayload;
const CommandPreprocessor = @import("command_preprocessor.zig").CommandPreprocessor;

pub const GetCommandInput = struct {
    /// The unique identifier of the command for which you want to retrieve
    /// information.
    command_id: []const u8,

    pub const json_field_names = .{
        .command_id = "commandId",
    };
};

pub const GetCommandOutput = struct {
    /// The Amazon Resource Number (ARN) of the command. For example,
    /// `arn:aws:iot:::command/`
    command_arn: ?[]const u8 = null,

    /// The unique identifier of the command.
    command_id: ?[]const u8 = null,

    /// The timestamp, when the command was created.
    created_at: ?i64 = null,

    /// Indicates whether the command has been deprecated.
    deprecated: ?bool = null,

    /// A short text description of the command.
    description: ?[]const u8 = null,

    /// The user-friendly name in the console for the command.
    display_name: ?[]const u8 = null,

    /// The timestamp, when the command was last updated.
    last_updated_at: ?i64 = null,

    /// A list of parameters for the command created.
    mandatory_parameters: ?[]const CommandParameter = null,

    /// The namespace of the command.
    namespace: ?CommandNamespace = null,

    /// The payload object that you provided for the command.
    payload: ?CommandPayload = null,

    /// The payload template for the dynamic command.
    payload_template: ?[]const u8 = null,

    /// Indicates whether the command is being deleted.
    pending_deletion: ?bool = null,

    /// Configuration that determines how `payloadTemplate` is processed to generate
    /// command execution payload.
    preprocessor: ?CommandPreprocessor = null,

    /// The IAM role that you provided when creating the command with
    /// `AWS-IoT-FleetWise`
    /// as the namespace.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .command_id = "commandId",
        .created_at = "createdAt",
        .deprecated = "deprecated",
        .description = "description",
        .display_name = "displayName",
        .last_updated_at = "lastUpdatedAt",
        .mandatory_parameters = "mandatoryParameters",
        .namespace = "namespace",
        .payload = "payload",
        .payload_template = "payloadTemplate",
        .pending_deletion = "pendingDeletion",
        .preprocessor = "preprocessor",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommandInput, options: CallOptions) !GetCommandOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/commands/");
    try path_buf.appendSlice(allocator, input.command_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommandOutput {
    const result: GetCommandOutput = try aws.json.parseJsonObject(
        GetCommandOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
