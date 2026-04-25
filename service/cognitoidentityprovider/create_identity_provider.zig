const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IdentityProviderTypeType = @import("identity_provider_type_type.zig").IdentityProviderTypeType;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;

pub const CreateIdentityProviderInput = struct {
    /// A mapping of IdP attributes to standard and custom user pool attributes.
    /// Specify a
    /// user pool attribute as the key of the key-value pair, and the IdP attribute
    /// claim name
    /// as the value.
    attribute_mapping: ?[]const aws.map.StringMapEntry = null,

    /// An array of IdP identifiers, for example `"IdPIdentifiers": [ "MyIdP",
    /// "MyIdP2"
    /// ]`. Identifiers are friendly names that you can pass in the
    /// `idp_identifier` query parameter of requests to the [Authorize
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) to silently redirect to sign-in with the associated IdP.
    /// Identifiers in a domain format also enable the use of [email-address
    /// matching with SAML
    /// providers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managing-saml-idp-naming.html).
    idp_identifiers: ?[]const []const u8 = null,

    /// The scopes, URLs, and identifiers for your external identity provider. The
    /// following
    /// examples describe the provider detail keys for each IdP type. These values
    /// and their
    /// schema are subject to change. Social IdP `authorize_scopes` values must
    /// match
    /// the values listed here.
    ///
    /// **OpenID Connect (OIDC)**
    ///
    /// Amazon Cognito accepts the following elements when it can't discover
    /// endpoint
    /// URLs from `oidc_issuer`: `attributes_url`,
    /// `authorize_url`, `jwks_uri`,
    /// `token_url`.
    ///
    /// Create or update request: `"ProviderDetails": {
    /// "attributes_request_method": "GET", "attributes_url":
    /// "https://auth.example.com/userInfo", "authorize_scopes": "openid profile
    /// email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_request_method":
    /// "GET", "attributes_url": "https://auth.example.com/userInfo",
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "openid
    /// profile email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// **SAML**
    ///
    /// Create or update request with Metadata URL: `"ProviderDetails": { "IDPInit":
    /// "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true", "MetadataURL":
    /// "https://auth.example.com/sso/saml/metadata", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// Create or update request with Metadata file: `"ProviderDetails": {
    /// "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "MetadataFile": "[metadata XML]", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// The value of `MetadataFile` must be the plaintext metadata document with all
    /// quote (") characters escaped by backslashes.
    ///
    /// Describe response: `"ProviderDetails": { "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "ActiveEncryptionCertificate": "[certificate]",
    /// "MetadataURL": "https://auth.example.com/sso/saml/metadata",
    /// "RequestSigningAlgorithm":
    /// "rsa-sha256", "SLORedirectBindingURI":
    /// "https://auth.example.com/slo/saml", "SSORedirectBindingURI":
    /// "https://auth.example.com/sso/saml" }`
    ///
    /// **LoginWithAmazon**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "profile postal_code", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret"`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://api.amazon.com/user/profile", "attributes_url_add_attributes":
    /// "false", "authorize_scopes": "profile postal_code", "authorize_url":
    /// "https://www.amazon.com/ap/oa", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret", "token_request_method": "POST",
    /// "token_url": "https://api.amazon.com/auth/o2/token" }`
    ///
    /// **Google**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email profile openid", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://people.googleapis.com/v1/people/me?personFields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes": "email
    /// profile openid", "authorize_url":
    /// "https://accounts.google.com/o/oauth2/v2/auth", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret", "oidc_issuer":
    /// "https://accounts.google.com", "token_request_method": "POST",
    /// "token_url": "https://www.googleapis.com/oauth2/v4/token"
    /// }`
    ///
    /// **SignInWithApple**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email name", "client_id": "com.example.cognito", "private_key": "1EXAMPLE",
    /// "key_id": "2EXAMPLE", "team_id": "3EXAMPLE" }`
    ///
    /// Describe response: `"ProviderDetails": {
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "email
    /// name", "authorize_url": "https://appleid.apple.com/auth/authorize",
    /// "client_id": "com.example.cognito", "key_id": "1EXAMPLE", "oidc_issuer":
    /// "https://appleid.apple.com", "team_id": "2EXAMPLE",
    /// "token_request_method": "POST", "token_url":
    /// "https://appleid.apple.com/auth/token" }`
    ///
    /// **Facebook**
    ///
    /// Create or update request: `"ProviderDetails": { "api_version": "v17.0",
    /// "authorize_scopes": "public_profile, email", "client_id":
    /// "1example23456789",
    /// "client_secret": "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails":
    /// { "api_version": "v17.0", "attributes_url":
    /// "https://graph.facebook.com/v17.0/me?fields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes":
    /// "public_profile, email",
    /// "authorize_url": "https://www.facebook.com/v17.0/dialog/oauth", "client_id":
    /// "1example23456789", "client_secret": "provider-app-client-secret",
    /// "token_request_method":
    /// "GET", "token_url": "https://graph.facebook.com/v17.0/oauth/access_token" }`
    provider_details: []const aws.map.StringMapEntry,

    /// The name that you want to assign to the IdP. You can pass the identity
    /// provider name
    /// in the `identity_provider` query parameter of requests to the [Authorize
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) to silently redirect to sign-in with the associated
    /// IdP.
    provider_name: []const u8,

    /// The type of IdP that you want to add. Amazon Cognito supports OIDC, SAML
    /// 2.0, Login With
    /// Amazon, Sign In With Apple, Google, and Facebook IdPs.
    provider_type: IdentityProviderTypeType,

    /// The Id of the user pool where you want to create an IdP.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .attribute_mapping = "AttributeMapping",
        .idp_identifiers = "IdpIdentifiers",
        .provider_details = "ProviderDetails",
        .provider_name = "ProviderName",
        .provider_type = "ProviderType",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateIdentityProviderOutput = struct {
    /// The details of the new user pool IdP.
    identity_provider: ?IdentityProviderType = null,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdentityProviderInput, options: CallOptions) !CreateIdentityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cognito-idp");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIdentityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateIdentityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIdentityProviderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIdentityProviderOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
