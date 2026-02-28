const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const PolicyDefinitionDetail = @import("policy_definition_detail.zig").PolicyDefinitionDetail;
const PolicyEffect = @import("policy_effect.zig").PolicyEffect;
const PolicyType = @import("policy_type.zig").PolicyType;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

pub const GetPolicyInput = struct {
    /// Specifies the ID of the policy you want information about.
    policy_id: []const u8,

    /// Specifies the ID of the policy store that contains the policy that you want
    /// information about.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
    };
};

pub const GetPolicyOutput = struct {
    /// The action that a policy permits or forbids. For example, `{"actions":
    /// [{"actionId": "ViewPhoto", "actionType": "PhotoFlash::Action"}, {"entityID":
    /// "SharePhoto", "entityType": "PhotoFlash::Action"}]}`.
    actions: ?[]const ActionIdentifier = null,

    /// The date and time that the policy was originally created.
    created_date: i64,

    /// The definition of the requested policy.
    definition: ?PolicyDefinitionDetail = null,

    /// The effect of the decision that a policy returns to an authorization
    /// request. For example, `"effect": "Permit"`.
    effect: ?PolicyEffect = null,

    /// The date and time that the policy was last updated.
    last_updated_date: i64,

    /// The unique ID of the policy that you want information about.
    policy_id: []const u8,

    /// The ID of the policy store that contains the policy that you want
    /// information about.
    policy_store_id: []const u8,

    /// The type of the policy.
    policy_type: PolicyType,

    /// The principal specified in the policy's scope. This element isn't included
    /// in the response when `Principal` isn't present in the policy content.
    principal: ?EntityIdentifier = null,

    /// The resource specified in the policy's scope. This element isn't included in
    /// the response when `Resource` isn't present in the policy content.
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .actions = "actions",
        .created_date = "createdDate",
        .definition = "definition",
        .effect = "effect",
        .last_updated_date = "lastUpdatedDate",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
        .policy_type = "policyType",
        .principal = "principal",
        .resource = "resource",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyInput, options: Options) !GetPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "verifiedpermissions");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "VerifiedPermissions.GetPolicy");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetPolicyOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
