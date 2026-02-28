const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const ContextDefinition = @import("context_definition.zig").ContextDefinition;
const EntitiesDefinition = @import("entities_definition.zig").EntitiesDefinition;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;
const Decision = @import("decision.zig").Decision;
const DeterminingPolicyItem = @import("determining_policy_item.zig").DeterminingPolicyItem;
const EvaluationErrorItem = @import("evaluation_error_item.zig").EvaluationErrorItem;

pub const IsAuthorizedWithTokenInput = struct {
    /// Specifies an access token for the principal to be authorized. This token is
    /// provided to you by the identity provider (IdP) associated with the specified
    /// identity source. You must specify either an `accessToken`, an
    /// `identityToken`, or both.
    ///
    /// Must be an access token. Verified Permissions returns an error if the
    /// `token_use` claim in the submitted token isn't `access`.
    access_token: ?[]const u8 = null,

    /// Specifies the requested action to be authorized. Is the specified principal
    /// authorized to perform this action on the specified resource.
    action: ?ActionIdentifier = null,

    /// Specifies additional context that can be used to make more granular
    /// authorization decisions.
    context: ?ContextDefinition = null,

    /// (Optional) Specifies the list of resources and their associated attributes
    /// that Verified Permissions can examine when evaluating the policies. These
    /// additional entities and their attributes can be referenced and checked by
    /// conditional elements in the policies in the specified policy store.
    ///
    /// You can't include principals in this parameter, only resource and action
    /// entities. This parameter can't include any entities of a type that matches
    /// the user or group entity types that you defined in your identity source.
    ///
    /// * The `IsAuthorizedWithToken` operation takes principal attributes from **
    ///   *only* ** the `identityToken` or `accessToken` passed to the operation.
    /// * For action entities, you can include only their `Identifier` and
    ///   `EntityType`.
    entities: ?EntitiesDefinition = null,

    /// Specifies an identity token for the principal to be authorized. This token
    /// is provided to you by the identity provider (IdP) associated with the
    /// specified identity source. You must specify either an `accessToken`, an
    /// `identityToken`, or both.
    ///
    /// Must be an ID token. Verified Permissions returns an error if the
    /// `token_use` claim in the submitted token isn't `id`.
    identity_token: ?[]const u8 = null,

    /// Specifies the ID of the policy store. Policies in this policy store will be
    /// used to make an authorization decision for the input.
    policy_store_id: []const u8,

    /// Specifies the resource for which the authorization decision is made. For
    /// example, is the principal allowed to perform the action on the resource?
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .action = "action",
        .context = "context",
        .entities = "entities",
        .identity_token = "identityToken",
        .policy_store_id = "policyStoreId",
        .resource = "resource",
    };
};

pub const IsAuthorizedWithTokenOutput = struct {
    /// An authorization decision that indicates if the authorization request should
    /// be allowed or denied.
    decision: Decision,

    /// The list of determining policies used to make the authorization decision.
    /// For example, if there are multiple matching policies, where at least one is
    /// a forbid policy, then because forbid always overrides permit the forbid
    /// policies are the determining policies. If all matching policies are permit
    /// policies, then those policies are the determining policies. When no policies
    /// match and the response is the default DENY, there are no determining
    /// policies.
    determining_policies: ?[]const DeterminingPolicyItem = null,

    /// Errors that occurred while making an authorization decision. For example, a
    /// policy references an entity or entity attribute that does not exist in the
    /// slice.
    errors: ?[]const EvaluationErrorItem = null,

    /// The identifier of the principal in the ID or access token.
    principal: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .decision = "decision",
        .determining_policies = "determiningPolicies",
        .errors = "errors",
        .principal = "principal",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IsAuthorizedWithTokenInput, options: Options) !IsAuthorizedWithTokenOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: IsAuthorizedWithTokenInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "VerifiedPermissions.IsAuthorizedWithToken");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !IsAuthorizedWithTokenOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(IsAuthorizedWithTokenOutput, body, alloc);
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
