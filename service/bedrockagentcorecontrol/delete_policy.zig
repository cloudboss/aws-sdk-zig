const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const DeletePolicyInput = struct {
    /// The identifier of the policy engine that manages the policy to be deleted.
    /// This ensures the policy is deleted from the correct policy engine context.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy to be deleted. This must be a valid
    /// policy ID that exists within the specified policy engine.
    policy_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
    };
};

pub const DeletePolicyOutput = struct {
    /// The timestamp when the deleted policy was originally created.
    created_at: i64,

    definition: ?PolicyDefinition = null,

    /// The human-readable description of the deleted policy.
    description: ?[]const u8 = null,

    /// The customer-assigned name of the deleted policy. This confirms which policy
    /// was successfully removed from the system and matches the name that was
    /// originally assigned during policy creation.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the deleted policy. This globally unique
    /// identifier confirms which policy resource was successfully removed.
    policy_arn: []const u8,

    /// The identifier of the policy engine from which the policy was deleted. This
    /// confirms the policy engine context for the deletion operation.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy being deleted. This confirms which
    /// policy the deletion operation targets.
    policy_id: []const u8,

    /// The status of the policy deletion operation. This provides information about
    /// any issues that occurred during the deletion process.
    status: PolicyStatus,

    /// Additional information about the deletion status. This provides details
    /// about the deletion process or any issues that may have occurred.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the deleted policy was last modified before deletion.
    /// This tracks the final state of the policy before it was removed from the
    /// system.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition = "definition",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePolicyInput, options: Options) !DeletePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentcorecontrol");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentcorecontrol", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .DELETE;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePolicyOutput {
    var result: DeletePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeletePolicyOutput, body, allocator);
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
