const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProviderUserIdentifierType = @import("provider_user_identifier_type.zig").ProviderUserIdentifierType;

pub const AdminLinkProviderForUserInput = struct {
    /// The existing user in the user pool that you want to assign to the external
    /// IdP user
    /// account. This user can be a local (Username + Password) Amazon Cognito user
    /// pools user or a
    /// federated user (for example, a SAML or Facebook user). If the user doesn't
    /// exist, Amazon Cognito
    /// generates an exception. Amazon Cognito returns this user when the new user
    /// (with the linked IdP
    /// attribute) signs in.
    ///
    /// For a native username + password user, the `ProviderAttributeValue` for the
    /// `DestinationUser` should be the username in the user pool. For a
    /// federated user, it should be the provider-specific `user_id`.
    ///
    /// The `ProviderAttributeName` of the `DestinationUser` is
    /// ignored.
    ///
    /// The `ProviderName` should be set to `Cognito` for users in
    /// Cognito user pools.
    ///
    /// All attributes in the DestinationUser profile must be mutable. If you have
    /// assigned the user any immutable custom attributes, the operation won't
    /// succeed.
    destination_user: ProviderUserIdentifierType,

    /// An external IdP account for a user who doesn't exist yet in the user pool.
    /// This user
    /// must be a federated user (for example, a SAML or Facebook user), not another
    /// native
    /// user.
    ///
    /// If the `SourceUser` is using a federated social IdP, such as Facebook,
    /// Google, or Login with Amazon, you must set the `ProviderAttributeName` to
    /// `Cognito_Subject`. For social IdPs, the `ProviderName` will be
    /// `Facebook`, `Google`, or `LoginWithAmazon`, and
    /// Amazon Cognito will automatically parse the Facebook, Google, and Login with
    /// Amazon tokens for
    /// `id`, `sub`, and `user_id`, respectively. The
    /// `ProviderAttributeValue` for the user must be the same value as the
    /// `id`, `sub`, or `user_id` value found in the social
    /// IdP token.
    ///
    /// For OIDC, the `ProviderAttributeName` can be any mapped value from a claim
    /// in the ID token, or that your app retrieves from the `userInfo` endpoint.
    /// For
    /// SAML, the `ProviderAttributeName` can be any mapped value from a claim in
    /// the
    /// SAML assertion.
    ///
    /// The following additional considerations apply to `SourceUser` for OIDC and
    /// SAML providers.
    ///
    /// * You must map the claim to a user pool attribute in your IdP configuration,
    ///   and
    /// set the user pool attribute name as the value of
    /// `ProviderAttributeName` in your
    /// `AdminLinkProviderForUser` request. For example,
    /// `email`.
    ///
    /// * When you set `ProviderAttributeName` to
    /// `Cognito_Subject`, Amazon Cognito will automatically parse the default
    /// unique identifier found in the subject from the IdP token.
    source_user: ProviderUserIdentifierType,

    /// The ID of the user pool where you want to link a federated identity.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .destination_user = "DestinationUser",
        .source_user = "SourceUser",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminLinkProviderForUserOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminLinkProviderForUserInput, options: Options) !AdminLinkProviderForUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cognitoidentityprovider");

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

fn serializeRequest(alloc: std.mem.Allocator, input: AdminLinkProviderForUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognitoidentityprovider", "Cognito Identity Provider", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminLinkProviderForUser");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AdminLinkProviderForUserOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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

    if (std.mem.eql(u8, error_code, "AliasExistsException")) {
        return .{ .arena = arena, .kind = .{ .alias_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeDeliveryFailureException")) {
        return .{ .arena = arena, .kind = .{ .code_delivery_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CodeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .code_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "DeviceKeyExistsException")) {
        return .{ .arena = arena, .kind = .{ .device_key_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateProviderException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EnableSoftwareTokenMFAException")) {
        return .{ .arena = arena, .kind = .{ .enable_software_token_mfa_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredCodeException")) {
        return .{ .arena = arena, .kind = .{ .expired_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureUnavailableInTierException")) {
        return .{ .arena = arena, .kind = .{ .feature_unavailable_in_tier_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GroupExistsException")) {
        return .{ .arena = arena, .kind = .{ .group_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEmailRoleAccessPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_email_role_access_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaResponseException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_response_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOAuthFlowException")) {
        return .{ .arena = arena, .kind = .{ .invalid_o_auth_flow_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPasswordException")) {
        return .{ .arena = arena, .kind = .{ .invalid_password_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleAccessPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sms_role_access_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSmsRoleTrustRelationshipException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sms_role_trust_relationship_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserPoolConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_pool_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManagedLoginBrandingExistsException")) {
        return .{ .arena = arena, .kind = .{ .managed_login_branding_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MFAMethodNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .mfa_method_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordHistoryPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .password_history_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordResetRequiredException")) {
        return .{ .arena = arena, .kind = .{ .password_reset_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionNotMetException")) {
        return .{ .arena = arena, .kind = .{ .precondition_not_met_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RefreshTokenReuseException")) {
        return .{ .arena = arena, .kind = .{ .refresh_token_reuse_exception = .{
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
    if (std.mem.eql(u8, error_code, "ScopeDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .scope_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SoftwareTokenMFANotFoundException")) {
        return .{ .arena = arena, .kind = .{ .software_token_mfa_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TermsExistsException")) {
        return .{ .arena = arena, .kind = .{ .terms_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TierChangeNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .tier_change_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyFailedAttemptsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_failed_attempts_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnexpectedLambdaException")) {
        return .{ .arena = arena, .kind = .{ .unexpected_lambda_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedIdentityProviderException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_identity_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTokenTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_token_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedUserStateException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_user_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserImportInProgressException")) {
        return .{ .arena = arena, .kind = .{ .user_import_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserLambdaValidationException")) {
        return .{ .arena = arena, .kind = .{ .user_lambda_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotConfirmedException")) {
        return .{ .arena = arena, .kind = .{ .user_not_confirmed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .user_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserPoolAddOnNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .user_pool_add_on_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserPoolTaggingException")) {
        return .{ .arena = arena, .kind = .{ .user_pool_tagging_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsernameExistsException")) {
        return .{ .arena = arena, .kind = .{ .username_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnChallengeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_challenge_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnClientMismatchException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_client_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnConfigurationMissingException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_configuration_missing_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnCredentialNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_credential_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnOriginNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_origin_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WebAuthnRelyingPartyMismatchException")) {
        return .{ .arena = arena, .kind = .{ .web_authn_relying_party_mismatch_exception = .{
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
