const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const CognitoIdentityProvider = @import("cognito_identity_provider.zig").CognitoIdentityProvider;

pub const CreateIdentityPoolInput = struct {
    /// Enables or disables the Basic (Classic) authentication flow. For more
    /// information, see
    /// [Identity Pools (Federated Identities) Authentication
    /// Flow](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flow.html) in the
    /// *Amazon Cognito Developer Guide*.
    allow_classic_flow: ?bool = null,

    /// TRUE if the identity pool supports unauthenticated logins.
    allow_unauthenticated_identities: ?bool = null,

    /// An array of Amazon Cognito user pools and their client IDs.
    cognito_identity_providers: ?[]const CognitoIdentityProvider = null,

    /// The "domain" by which Cognito will refer to your users. This name acts as a
    /// placeholder that allows your backend and the Cognito service to communicate
    /// about the
    /// developer provider. For the `DeveloperProviderName`, you can use letters as
    /// well
    /// as period (`.`), underscore (`_`), and dash
    /// (`-`).
    ///
    /// Once you have set a developer provider name, you cannot change it. Please
    /// take care
    /// in setting this parameter.
    developer_provider_name: ?[]const u8 = null,

    /// A string that you provide.
    identity_pool_name: []const u8,

    /// Tags to assign to the identity pool. A tag is a label that you can apply to
    /// identity
    /// pools to categorize and manage them in different ways, such as by purpose,
    /// owner,
    /// environment, or other criteria.
    identity_pool_tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Names (ARN) of the OpenID Connect providers.
    open_id_connect_provider_ar_ns: ?[]const []const u8 = null,

    /// An array of Amazon Resource Names (ARNs) of the SAML provider for your
    /// identity
    /// pool.
    saml_provider_ar_ns: ?[]const []const u8 = null,

    /// Optional key:value pairs mapping provider names to provider app IDs.
    supported_login_providers: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allow_classic_flow = "AllowClassicFlow",
        .allow_unauthenticated_identities = "AllowUnauthenticatedIdentities",
        .cognito_identity_providers = "CognitoIdentityProviders",
        .developer_provider_name = "DeveloperProviderName",
        .identity_pool_name = "IdentityPoolName",
        .identity_pool_tags = "IdentityPoolTags",
        .open_id_connect_provider_ar_ns = "OpenIdConnectProviderARNs",
        .saml_provider_ar_ns = "SamlProviderARNs",
        .supported_login_providers = "SupportedLoginProviders",
    };
};

pub const CreateIdentityPoolOutput = struct {
    /// Enables or disables the Basic (Classic) authentication flow. For more
    /// information, see
    /// [Identity Pools (Federated Identities) Authentication
    /// Flow](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flow.html) in the
    /// *Amazon Cognito Developer Guide*.
    allow_classic_flow: ?bool = null,

    /// TRUE if the identity pool supports unauthenticated logins.
    allow_unauthenticated_identities: ?bool = null,

    /// A list representing an Amazon Cognito user pool and its client ID.
    cognito_identity_providers: ?[]const CognitoIdentityProvider = null,

    /// The "domain" by which Cognito will refer to your users.
    developer_provider_name: ?[]const u8 = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// A string that you provide.
    identity_pool_name: []const u8,

    /// The tags that are assigned to the identity pool. A tag is a label that you
    /// can apply to
    /// identity pools to categorize and manage them in different ways, such as by
    /// purpose, owner,
    /// environment, or other criteria.
    identity_pool_tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARNs of the OpenID Connect providers.
    open_id_connect_provider_ar_ns: ?[]const []const u8 = null,

    /// An array of Amazon Resource Names (ARNs) of the SAML provider for your
    /// identity
    /// pool.
    saml_provider_ar_ns: ?[]const []const u8 = null,

    /// Optional key:value pairs mapping provider names to provider app IDs.
    supported_login_providers: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allow_classic_flow = "AllowClassicFlow",
        .allow_unauthenticated_identities = "AllowUnauthenticatedIdentities",
        .cognito_identity_providers = "CognitoIdentityProviders",
        .developer_provider_name = "DeveloperProviderName",
        .identity_pool_id = "IdentityPoolId",
        .identity_pool_name = "IdentityPoolName",
        .identity_pool_tags = "IdentityPoolTags",
        .open_id_connect_provider_ar_ns = "OpenIdConnectProviderARNs",
        .saml_provider_ar_ns = "SamlProviderARNs",
        .supported_login_providers = "SupportedLoginProviders",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdentityPoolInput, options: CallOptions) !CreateIdentityPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-identity", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIdentityPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.CreateIdentityPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIdentityPoolOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIdentityPoolOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DeveloperUserAlreadyRegisteredException")) {
        const parsed_error: ?errors.DeveloperUserAlreadyRegisteredException = aws.json.parseJsonObject(errors.DeveloperUserAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .developer_user_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExternalServiceException")) {
        const parsed_error: ?errors.ExternalServiceException = aws.json.parseJsonObject(errors.ExternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .external_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        const parsed_error: ?errors.InternalErrorException = aws.json.parseJsonObject(errors.InternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIdentityPoolConfigurationException")) {
        const parsed_error: ?errors.InvalidIdentityPoolConfigurationException = aws.json.parseJsonObject(errors.InvalidIdentityPoolConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_identity_pool_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        const parsed_error: ?errors.NotAuthorizedException = aws.json.parseJsonObject(errors.NotAuthorizedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_authorized_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        const parsed_error: ?errors.ResourceConflictException = aws.json.parseJsonObject(errors.ResourceConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?errors.TooManyRequestsException = aws.json.parseJsonObject(errors.TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
