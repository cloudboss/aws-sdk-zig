const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegistryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .encryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
