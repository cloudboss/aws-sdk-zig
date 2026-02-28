const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AssetType = @import("asset_type.zig").AssetType;
const ManagedLoginBrandingType = @import("managed_login_branding_type.zig").ManagedLoginBrandingType;

pub const CreateManagedLoginBrandingInput = struct {
    /// An array of image files that you want to apply to functions like
    /// backgrounds, logos,
    /// and icons. Each object must also indicate whether it is for dark mode, light
    /// mode, or
    /// browser-adaptive mode.
    assets: ?[]const AssetType = null,

    /// The app client that you want to create the branding style for. Each style is
    /// linked to
    /// an app client until you delete it.
    client_id: []const u8,

    /// A JSON file, encoded as a `Document` type, with the the settings that you
    /// want to apply to your style.
    ///
    /// The following components are not currently implemented and reserved for
    /// future
    /// use:
    ///
    /// * `signUp`
    ///
    /// * `instructions`
    ///
    /// * `sessionTimerDisplay`
    ///
    /// * `languageSelector` (for localization, see [Managed login
    ///   localization)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-localization)
    settings: ?[]const u8 = null,

    /// When true, applies the default branding style options. These default options
    /// are
    /// managed by Amazon Cognito. You can modify them later in the branding editor.
    ///
    /// When you specify `true` for this option, you must also omit values for
    /// `Settings` and `Assets` in the request.
    use_cognito_provided_values: ?bool = null,

    /// The ID of the user pool where you want to create a new branding style.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .assets = "Assets",
        .client_id = "ClientId",
        .settings = "Settings",
        .use_cognito_provided_values = "UseCognitoProvidedValues",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateManagedLoginBrandingOutput = struct {
    /// The details of the branding style that you created.
    managed_login_branding: ?ManagedLoginBrandingType = null,

    pub const json_field_names = .{
        .managed_login_branding = "ManagedLoginBranding",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateManagedLoginBrandingInput, options: Options) !CreateManagedLoginBrandingOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateManagedLoginBrandingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateManagedLoginBranding");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateManagedLoginBrandingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateManagedLoginBrandingOutput, body, alloc);
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
