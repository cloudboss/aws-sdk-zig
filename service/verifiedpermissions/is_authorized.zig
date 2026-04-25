const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const ContextDefinition = @import("context_definition.zig").ContextDefinition;
const EntitiesDefinition = @import("entities_definition.zig").EntitiesDefinition;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;
const Decision = @import("decision.zig").Decision;
const DeterminingPolicyItem = @import("determining_policy_item.zig").DeterminingPolicyItem;
const EvaluationErrorItem = @import("evaluation_error_item.zig").EvaluationErrorItem;

pub const IsAuthorizedInput = struct {
    /// Specifies the requested action to be authorized. For example, is the
    /// principal authorized to perform this action on the resource?
    action: ?ActionIdentifier = null,

    /// Specifies additional context that can be used to make more granular
    /// authorization decisions.
    context: ?ContextDefinition = null,

    /// (Optional) Specifies the list of resources and principals and their
    /// associated attributes that Verified Permissions can examine when evaluating
    /// the policies. These additional entities and their attributes can be
    /// referenced and checked by conditional elements in the policies in the
    /// specified policy store.
    ///
    /// You can include only principal and resource entities in this parameter; you
    /// can't include actions. You must specify actions in the schema.
    entities: ?EntitiesDefinition = null,

    /// Specifies the ID of the policy store. Policies in this policy store will be
    /// used to make an authorization decision for the input.
    ///
    /// To specify a policy store, use its ID or alias name. When using an alias
    /// name, prefix it with `policy-store-alias/`. For example:
    ///
    /// * ID: `PSEXAMPLEabcdefg111111`
    /// * Alias name: `policy-store-alias/example-policy-store`
    ///
    /// To view aliases, use
    /// [ListPolicyStoreAliases](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyStoreAliases.html).
    policy_store_id: []const u8,

    /// Specifies the principal for which the authorization decision is to be made.
    principal: ?EntityIdentifier = null,

    /// Specifies the resource for which the authorization decision is to be made.
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .action = "action",
        .context = "context",
        .entities = "entities",
        .policy_store_id = "policyStoreId",
        .principal = "principal",
        .resource = "resource",
    };
};

pub const IsAuthorizedOutput = struct {
    /// An authorization decision that indicates if the authorization request should
    /// be allowed or denied.
    decision: Decision,

    /// The list of determining policies used to make the authorization decision.
    /// For example, if there are two matching policies, where one is a forbid and
    /// the other is a permit, then the forbid policy will be the determining
    /// policy. In the case of multiple matching permit policies then there would be
    /// multiple determining policies. In the case that no policies match, and hence
    /// the response is DENY, there would be no determining policies.
    determining_policies: ?[]const DeterminingPolicyItem = null,

    /// Errors that occurred while making an authorization decision, for example, a
    /// policy references an Entity or entity Attribute that does not exist in the
    /// slice.
    errors: ?[]const EvaluationErrorItem = null,

    pub const json_field_names = .{
        .decision = "decision",
        .determining_policies = "determiningPolicies",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IsAuthorizedInput, options: CallOptions) !IsAuthorizedOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "verifiedpermissions");

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

fn serializeRequest(allocator: std.mem.Allocator, input: IsAuthorizedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.IsAuthorized");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IsAuthorizedOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(IsAuthorizedOutput, body, allocator);
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
