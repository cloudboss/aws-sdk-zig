const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

pub const GetRegistryInput = struct {
    /// The identifier of the registry to retrieve. You can specify either the
    /// Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    pub const json_field_names = .{
        .registry_id = "registryId",
    };
};

pub const GetRegistryOutput = struct {
    /// The approval configuration for registry records. For details, see the
    /// `ApprovalConfiguration` data type.
    approval_configuration: ?ApprovalConfiguration = null,

    /// The authorizer configuration for the registry. For details, see the
    /// `AuthorizerConfiguration` data type.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer used by the registry. This controls the authorization
    /// method for the Search and Invoke APIs used by consumers.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: ?RegistryAuthorizerType = null,

    /// The timestamp when the registry was created.
    created_at: i64,

    /// The description of the registry.
    description: ?[]const u8 = null,

    /// The name of the registry.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: []const u8,

    /// The unique identifier of the registry.
    registry_id: []const u8,

    /// The current status of the registry. Possible values include `CREATING`,
    /// `READY`, `UPDATING`, `CREATE_FAILED`, `UPDATE_FAILED`, `DELETING`, and
    /// `DELETE_FAILED`.
    status: RegistryStatus,

    /// The reason for the current status, typically set when the status is a
    /// failure state.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the registry was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .registry_arn = "registryArn",
        .registry_id = "registryId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegistryInput, options: CallOptions) !GetRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegistryOutput {
    var result: GetRegistryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRegistryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
