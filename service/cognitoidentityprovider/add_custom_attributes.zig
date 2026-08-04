const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const SchemaAttributeType = @import("schema_attribute_type.zig").SchemaAttributeType;

pub const AddCustomAttributesInput = struct {
    /// An array of custom attribute names and other properties. Sets the following
    /// characteristics:
    ///
    /// **AttributeDataType**
    ///
    /// The expected data type. Can be a string, a number, a date and time, or a
    /// boolean.
    ///
    /// **Mutable**
    ///
    /// If true, you can grant app clients write access to the attribute value. If
    /// false, the attribute value can only be set up on sign-up or administrator
    /// creation of users.
    ///
    /// **Name**
    ///
    /// The attribute name. For an attribute like `custom:myAttribute`,
    /// enter `myAttribute` for this field.
    ///
    /// **Required**
    ///
    /// When true, users who sign up or are created must set a value for the
    /// attribute.
    ///
    /// **NumberAttributeConstraints**
    ///
    /// The minimum and maximum length of accepted values for a
    /// `Number`-type attribute.
    ///
    /// **StringAttributeConstraints**
    ///
    /// The minimum and maximum length of accepted values for a
    /// `String`-type attribute.
    ///
    /// **DeveloperOnlyAttribute**
    ///
    /// This legacy option creates an attribute with a `dev:` prefix.
    /// You can only set the value of a developer-only attribute with administrative
    /// IAM credentials.
    custom_attributes: []const SchemaAttributeType,

    /// The ID of the user pool where you want to add custom attributes.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .custom_attributes = "CustomAttributes",
        .user_pool_id = "UserPoolId",
    };
};

pub const AddCustomAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddCustomAttributesInput, options: CallOptions) !AddCustomAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddCustomAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AddCustomAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddCustomAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AliasExistsException")) {
        const parsed_error: ?errors.AliasExistsException = aws.json.parseJsonObject(errors.AliasExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .alias_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CodeDeliveryFailureException")) {
        const parsed_error: ?errors.CodeDeliveryFailureException = aws.json.parseJsonObject(errors.CodeDeliveryFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .code_delivery_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CodeMismatchException")) {
        const parsed_error: ?errors.CodeMismatchException = aws.json.parseJsonObject(errors.CodeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .code_mismatch_exception = typed_error } };
        }
    }
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
    if (std.mem.eql(u8, error_code, "DeviceKeyExistsException")) {
        const parsed_error: ?errors.DeviceKeyExistsException = aws.json.parseJsonObject(errors.DeviceKeyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .device_key_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateProviderException")) {
        const parsed_error: ?errors.DuplicateProviderException = aws.json.parseJsonObject(errors.DuplicateProviderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_provider_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EnableSoftwareTokenMFAException")) {
        const parsed_error: ?errors.EnableSoftwareTokenMFAException = aws.json.parseJsonObject(errors.EnableSoftwareTokenMFAException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .enable_software_token_mfa_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExpiredCodeException")) {
        const parsed_error: ?errors.ExpiredCodeException = aws.json.parseJsonObject(errors.ExpiredCodeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_code_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FeatureUnavailableInTierException")) {
        const parsed_error: ?errors.FeatureUnavailableInTierException = aws.json.parseJsonObject(errors.FeatureUnavailableInTierException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .feature_unavailable_in_tier_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        const parsed_error: ?errors.ForbiddenException = aws.json.parseJsonObject(errors.ForbiddenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .forbidden_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GroupExistsException")) {
        const parsed_error: ?errors.GroupExistsException = aws.json.parseJsonObject(errors.GroupExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .group_exists_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEmailRoleAccessPolicyException")) {
        const parsed_error: ?errors.InvalidEmailRoleAccessPolicyException = aws.json.parseJsonObject(errors.InvalidEmailRoleAccessPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_email_role_access_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaResponseException")) {
        const parsed_error: ?errors.InvalidLambdaResponseException = aws.json.parseJsonObject(errors.InvalidLambdaResponseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lambda_response_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOAuthFlowException")) {
        const parsed_error: ?errors.InvalidOAuthFlowException = aws.json.parseJsonObject(errors.InvalidOAuthFlowException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_o_auth_flow_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidPasswordException")) {
        const parsed_error: ?errors.InvalidPasswordException = aws.json.parseJsonObject(errors.InvalidPasswordException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_password_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleAccessPolicyException")) {
        const parsed_error: ?errors.InvalidSmsRoleAccessPolicyException = aws.json.parseJsonObject(errors.InvalidSmsRoleAccessPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sms_role_access_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleTrustRelationshipException")) {
        const parsed_error: ?errors.InvalidSmsRoleTrustRelationshipException = aws.json.parseJsonObject(errors.InvalidSmsRoleTrustRelationshipException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sms_role_trust_relationship_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUserPoolConfigurationException")) {
        const parsed_error: ?errors.InvalidUserPoolConfigurationException = aws.json.parseJsonObject(errors.InvalidUserPoolConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_user_pool_configuration_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ManagedLoginBrandingExistsException")) {
        const parsed_error: ?errors.ManagedLoginBrandingExistsException = aws.json.parseJsonObject(errors.ManagedLoginBrandingExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .managed_login_branding_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MFAMethodNotFoundException")) {
        const parsed_error: ?errors.MFAMethodNotFoundException = aws.json.parseJsonObject(errors.MFAMethodNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .mfa_method_not_found_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "PasswordHistoryPolicyViolationException")) {
        const parsed_error: ?errors.PasswordHistoryPolicyViolationException = aws.json.parseJsonObject(errors.PasswordHistoryPolicyViolationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .password_history_policy_violation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PasswordResetRequiredException")) {
        const parsed_error: ?errors.PasswordResetRequiredException = aws.json.parseJsonObject(errors.PasswordResetRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .password_reset_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        const parsed_error: ?errors.PreconditionNotMetException = aws.json.parseJsonObject(errors.PreconditionNotMetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RefreshTokenReuseException")) {
        const parsed_error: ?errors.RefreshTokenReuseException = aws.json.parseJsonObject(errors.RefreshTokenReuseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .refresh_token_reuse_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ScopeDoesNotExistException")) {
        const parsed_error: ?errors.ScopeDoesNotExistException = aws.json.parseJsonObject(errors.ScopeDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scope_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SoftwareTokenMFANotFoundException")) {
        const parsed_error: ?errors.SoftwareTokenMFANotFoundException = aws.json.parseJsonObject(errors.SoftwareTokenMFANotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .software_token_mfa_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TermsExistsException")) {
        const parsed_error: ?errors.TermsExistsException = aws.json.parseJsonObject(errors.TermsExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .terms_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TierChangeNotAllowedException")) {
        const parsed_error: ?errors.TierChangeNotAllowedException = aws.json.parseJsonObject(errors.TierChangeNotAllowedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tier_change_not_allowed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyFailedAttemptsException")) {
        const parsed_error: ?errors.TooManyFailedAttemptsException = aws.json.parseJsonObject(errors.TooManyFailedAttemptsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_failed_attempts_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        const parsed_error: ?errors.UnauthorizedException = aws.json.parseJsonObject(errors.UnauthorizedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unauthorized_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnexpectedLambdaException")) {
        const parsed_error: ?errors.UnexpectedLambdaException = aws.json.parseJsonObject(errors.UnexpectedLambdaException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unexpected_lambda_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedIdentityProviderException")) {
        const parsed_error: ?errors.UnsupportedIdentityProviderException = aws.json.parseJsonObject(errors.UnsupportedIdentityProviderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_identity_provider_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTokenTypeException")) {
        const parsed_error: ?errors.UnsupportedTokenTypeException = aws.json.parseJsonObject(errors.UnsupportedTokenTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_token_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserStateException")) {
        const parsed_error: ?errors.UnsupportedUserStateException = aws.json.parseJsonObject(errors.UnsupportedUserStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_user_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserImportInProgressException")) {
        const parsed_error: ?errors.UserImportInProgressException = aws.json.parseJsonObject(errors.UserImportInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_import_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserLambdaValidationException")) {
        const parsed_error: ?errors.UserLambdaValidationException = aws.json.parseJsonObject(errors.UserLambdaValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_lambda_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserNotConfirmedException")) {
        const parsed_error: ?errors.UserNotConfirmedException = aws.json.parseJsonObject(errors.UserNotConfirmedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_not_confirmed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundException")) {
        const parsed_error: ?errors.UserNotFoundException = aws.json.parseJsonObject(errors.UserNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserPoolAddOnNotEnabledException")) {
        const parsed_error: ?errors.UserPoolAddOnNotEnabledException = aws.json.parseJsonObject(errors.UserPoolAddOnNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_pool_add_on_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserPoolTaggingException")) {
        const parsed_error: ?errors.UserPoolTaggingException = aws.json.parseJsonObject(errors.UserPoolTaggingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_pool_tagging_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UsernameExistsException")) {
        const parsed_error: ?errors.UsernameExistsException = aws.json.parseJsonObject(errors.UsernameExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .username_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnChallengeNotFoundException")) {
        const parsed_error: ?errors.WebAuthnChallengeNotFoundException = aws.json.parseJsonObject(errors.WebAuthnChallengeNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_challenge_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnClientMismatchException")) {
        const parsed_error: ?errors.WebAuthnClientMismatchException = aws.json.parseJsonObject(errors.WebAuthnClientMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_client_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnConfigurationMissingException")) {
        const parsed_error: ?errors.WebAuthnConfigurationMissingException = aws.json.parseJsonObject(errors.WebAuthnConfigurationMissingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_configuration_missing_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnCredentialNotSupportedException")) {
        const parsed_error: ?errors.WebAuthnCredentialNotSupportedException = aws.json.parseJsonObject(errors.WebAuthnCredentialNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_credential_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnNotEnabledException")) {
        const parsed_error: ?errors.WebAuthnNotEnabledException = aws.json.parseJsonObject(errors.WebAuthnNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnOriginNotAllowedException")) {
        const parsed_error: ?errors.WebAuthnOriginNotAllowedException = aws.json.parseJsonObject(errors.WebAuthnOriginNotAllowedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_origin_not_allowed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WebAuthnRelyingPartyMismatchException")) {
        const parsed_error: ?errors.WebAuthnRelyingPartyMismatchException = aws.json.parseJsonObject(errors.WebAuthnRelyingPartyMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .web_authn_relying_party_mismatch_exception = typed_error } };
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
