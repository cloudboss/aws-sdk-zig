const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatedApprovalConfiguration = @import("updated_approval_configuration.zig").UpdatedApprovalConfiguration;
const UpdatedAuthorizerConfiguration = @import("updated_authorizer_configuration.zig").UpdatedAuthorizerConfiguration;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const ApprovalConfiguration = @import("approval_configuration.zig").ApprovalConfiguration;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;
const RegistryStatus = @import("registry_status.zig").RegistryStatus;

pub const UpdateRegistryInput = struct {
    /// The updated approval configuration for registry records. The updated
    /// configuration only affects new records that move to `PENDING_APPROVAL`
    /// status after the change. Existing records already in `PENDING_APPROVAL`
    /// status are not affected.
    approval_configuration: ?UpdatedApprovalConfiguration = null,

    /// The updated authorizer configuration for the registry. Changing the
    /// authorizer configuration can break existing consumers of the registry who
    /// are using the authorization type prior to the update.
    authorizer_configuration: ?UpdatedAuthorizerConfiguration = null,

    /// The updated description of the registry. To clear the description, include
    /// the `UpdatedDescription` wrapper with `optionalValue` not specified.
    description: ?UpdatedDescription = null,

    /// The updated name of the registry.
    name: ?[]const u8 = null,

    /// The identifier of the registry to update. You can specify either the Amazon
    /// Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    pub const json_field_names = .{
        .approval_configuration = "approvalConfiguration",
        .authorizer_configuration = "authorizerConfiguration",
        .description = "description",
        .name = "name",
        .registry_id = "registryId",
    };
};

pub const UpdateRegistryOutput = struct {
    /// The approval configuration for the updated registry. For details, see the
    /// `ApprovalConfiguration` data type.
    approval_configuration: ?ApprovalConfiguration = null,

    /// The authorizer configuration for the updated registry. For details, see the
    /// `AuthorizerConfiguration` data type.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer used by the updated registry. This controls the
    /// authorization method for the Search and Invoke APIs used by consumers.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: ?RegistryAuthorizerType = null,

    /// The timestamp when the registry was created.
    created_at: i64,

    /// The description of the updated registry.
    description: ?[]const u8 = null,

    /// The name of the updated registry.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the updated registry.
    registry_arn: []const u8,

    /// The unique identifier of the updated registry.
    registry_id: []const u8,

    /// The current status of the updated registry. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `CREATE_FAILED`, `UPDATE_FAILED`,
    /// `DELETING`, and `DELETE_FAILED`.
    status: RegistryStatus,

    /// The reason for the current status of the updated registry.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRegistryInput, options: CallOptions) !UpdateRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.approval_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"approvalConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRegistryOutput {
    var result: UpdateRegistryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRegistryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
