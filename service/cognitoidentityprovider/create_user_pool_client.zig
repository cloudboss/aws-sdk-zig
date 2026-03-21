const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const OAuthFlowType = @import("o_auth_flow_type.zig").OAuthFlowType;
const AnalyticsConfigurationType = @import("analytics_configuration_type.zig").AnalyticsConfigurationType;
const ExplicitAuthFlowsType = @import("explicit_auth_flows_type.zig").ExplicitAuthFlowsType;
const PreventUserExistenceErrorTypes = @import("prevent_user_existence_error_types.zig").PreventUserExistenceErrorTypes;
const RefreshTokenRotationType = @import("refresh_token_rotation_type.zig").RefreshTokenRotationType;
const TokenValidityUnitsType = @import("token_validity_units_type.zig").TokenValidityUnitsType;
const UserPoolClientType = @import("user_pool_client_type.zig").UserPoolClientType;

pub const CreateUserPoolClientInput = struct {
    /// The access token time limit. After this limit expires, your user can't use
    /// their access token. To specify the time unit for `AccessTokenValidity` as
    /// `seconds`, `minutes`, `hours`, or `days`,
    /// set a `TokenValidityUnits` value in your API request.
    ///
    /// For example, when you set `AccessTokenValidity` to `10` and
    /// `TokenValidityUnits` to `hours`, your user can authorize access with
    /// their access token for 10 hours.
    ///
    /// The default time unit for `AccessTokenValidity` in an API request is hours.
    /// *Valid range* is displayed below in seconds.
    ///
    /// If you don't specify otherwise in the configuration of your app client, your
    /// access
    /// tokens are valid for one hour.
    access_token_validity: ?i32 = null,

    /// The OAuth grant types that you want your app client to generate for clients
    /// in managed
    /// login authentication. To create an app client that generates client
    /// credentials grants,
    /// you must add `client_credentials` as the only allowed OAuth flow.
    ///
    /// **code**
    ///
    /// Use a code grant flow, which provides an authorization code as the
    /// response. This code can be exchanged for access tokens with the
    /// `/oauth2/token` endpoint.
    ///
    /// **implicit**
    ///
    /// Issue the access token, and the ID token when scopes like
    /// `openid` and `profile` are requested, directly to
    /// your user.
    ///
    /// **client_credentials**
    ///
    /// Issue the access token from the `/oauth2/token` endpoint
    /// directly to a non-person user, authorized by a combination of the client ID
    /// and client secret.
    allowed_o_auth_flows: ?[]const OAuthFlowType = null,

    /// Set to `true` to use OAuth 2.0 authorization server features in your app
    /// client.
    ///
    /// This parameter must have a value of `true` before you can configure
    /// the following features in your app client.
    ///
    /// * `CallBackURLs`: Callback URLs.
    ///
    /// * `LogoutURLs`: Sign-out redirect URLs.
    ///
    /// * `AllowedOAuthScopes`: OAuth 2.0 scopes.
    ///
    /// * `AllowedOAuthFlows`: Support for authorization code, implicit, and client
    ///   credentials OAuth 2.0 grants.
    ///
    /// To use authorization server features, configure one of these features in the
    /// Amazon Cognito console or set
    /// `AllowedOAuthFlowsUserPoolClient` to `true` in a `CreateUserPoolClient` or
    /// `UpdateUserPoolClient` API request. If you don't set a value for
    /// `AllowedOAuthFlowsUserPoolClient` in a request with the CLI or SDKs, it
    /// defaults
    /// to `false`. When `false`, only SDK-based API sign-in is permitted.
    allowed_o_auth_flows_user_pool_client: ?bool = null,

    /// The OAuth, OpenID Connect (OIDC), and custom scopes that you want to permit
    /// your app
    /// client to authorize access with. Scopes govern access control to user pool
    /// self-service
    /// API operations, user data from the `userInfo` endpoint, and third-party
    /// APIs.
    /// Scope values include `phone`, `email`, `openid`, and
    /// `profile`. The `aws.cognito.signin.user.admin` scope
    /// authorizes user self-service operations. Custom scopes with resource servers
    /// authorize
    /// access to external APIs.
    allowed_o_auth_scopes: ?[]const []const u8 = null,

    /// The user pool analytics configuration for collecting metrics and sending
    /// them to your
    /// Amazon Pinpoint campaign.
    ///
    /// In Amazon Web Services Regions where Amazon Pinpoint isn't available, user
    /// pools might not have access to
    /// analytics or might be configurable with campaigns in the US East (N.
    /// Virginia) Region.
    /// For more information, see [Using Amazon Pinpoint
    /// analytics](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-pinpoint-integration.html).
    analytics_configuration: ?AnalyticsConfigurationType = null,

    /// Amazon Cognito creates a session token for each API request in an
    /// authentication flow. `AuthSessionValidity` is the duration,
    /// in minutes, of that session token. Your user pool native user must respond
    /// to each authentication challenge before the session expires.
    auth_session_validity: ?i32 = null,

    /// A list of allowed redirect, or callback, URLs for managed login
    /// authentication. These
    /// URLs are the paths where you want to send your users' browsers after they
    /// complete
    /// authentication with managed login or a third-party IdP. Typically, callback
    /// URLs are the
    /// home of an application that uses OAuth or OIDC libraries to process
    /// authentication
    /// outcomes.
    ///
    /// A redirect URI must meet the following requirements:
    ///
    /// * Be an absolute URI.
    ///
    /// * Be registered with the authorization server. Amazon Cognito doesn't accept
    /// authorization requests with `redirect_uri` values that aren't in
    /// the list of `CallbackURLs` that you provide in this parameter.
    ///
    /// * Not include a fragment component.
    ///
    /// See [OAuth 2.0 -
    /// Redirection Endpoint](https://tools.ietf.org/html/rfc6749#section-3.1.2).
    ///
    /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
    /// testing purposes
    /// only.
    ///
    /// App callback URLs such as myapp://example are also supported.
    callback_ur_ls: ?[]const []const u8 = null,

    /// A friendly name for the app client that you want to create.
    client_name: []const u8,

    /// The default redirect URI. In app clients with one assigned IdP, replaces
    /// `redirect_uri` in authentication requests. Must be in the
    /// `CallbackURLs` list.
    default_redirect_uri: ?[]const u8 = null,

    /// When `true`, your application can include additional
    /// `UserContextData` in authentication requests. This data includes the IP
    /// address, and contributes to analysis by threat protection features. For more
    /// information
    /// about propagation of user context data, see [Adding session data to API
    /// requests](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint). If you don’t include this parameter,
    /// you can't send the source IP address to Amazon Cognito threat protection
    /// features. You can only
    /// activate `EnablePropagateAdditionalUserContextData` in an app client that
    /// has
    /// a client secret.
    enable_propagate_additional_user_context_data: ?bool = null,

    /// Activates or deactivates [token
    /// revocation](https://docs.aws.amazon.com/cognito/latest/developerguide/token-revocation.html) in the target app client.
    ///
    /// If you don't include this parameter, token revocation is automatically
    /// activated for
    /// the new user pool client.
    enable_token_revocation: ?bool = null,

    /// The [authentication
    /// flows](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow-methods.html) that you want your user pool client to support. For each app
    /// client in your user pool, you can sign in your users with any combination of
    /// one or more flows, including with
    /// a user name and Secure Remote Password (SRP), a user name and password, or a
    /// custom authentication process that
    /// you define with Lambda functions.
    ///
    /// If you don't specify a value for `ExplicitAuthFlows`, your app client
    /// supports
    /// `ALLOW_REFRESH_TOKEN_AUTH`, `ALLOW_USER_SRP_AUTH`, and `ALLOW_CUSTOM_AUTH`.
    ///
    /// The values for authentication flow options include the following.
    ///
    /// * `ALLOW_USER_AUTH`: Enable selection-based sign-in
    /// with `USER_AUTH`. This setting covers username-password,
    /// secure remote password (SRP), passwordless, and passkey authentication.
    /// This authentiation flow can do username-password and SRP authentication
    /// without other `ExplicitAuthFlows` permitting them. For example
    /// users can complete an SRP challenge through `USER_AUTH`
    /// without the flow `USER_SRP_AUTH` being active for the app
    /// client. This flow doesn't include `CUSTOM_AUTH`.
    ///
    /// To activate this setting, your user pool must be in the [
    /// Essentials
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
    ///
    /// * `ALLOW_ADMIN_USER_PASSWORD_AUTH`: Enable admin based user password
    /// authentication flow `ADMIN_USER_PASSWORD_AUTH`. This setting replaces
    /// the `ADMIN_NO_SRP_AUTH` setting. With this authentication flow, your app
    /// passes a user name and password to Amazon Cognito in the request, instead of
    /// using the Secure
    /// Remote Password (SRP) protocol to securely transmit the password.
    ///
    /// * `ALLOW_CUSTOM_AUTH`: Enable Lambda trigger based
    /// authentication.
    ///
    /// * `ALLOW_USER_PASSWORD_AUTH`: Enable user password-based
    /// authentication. In this flow, Amazon Cognito receives the password in the
    /// request instead
    /// of using the SRP protocol to verify passwords.
    ///
    /// * `ALLOW_USER_SRP_AUTH`: Enable SRP-based authentication.
    ///
    /// * `ALLOW_REFRESH_TOKEN_AUTH`: Enable authflow to refresh
    /// tokens.
    ///
    /// In some environments, you will see the values `ADMIN_NO_SRP_AUTH`,
    /// `CUSTOM_AUTH_FLOW_ONLY`, or `USER_PASSWORD_AUTH`.
    /// You can't assign these legacy `ExplicitAuthFlows` values to user pool
    /// clients at the same time as values that begin with `ALLOW_`,
    /// like `ALLOW_USER_SRP_AUTH`.
    explicit_auth_flows: ?[]const ExplicitAuthFlowsType = null,

    /// When `true`, generates a client secret for the app client. Client secrets
    /// are used with server-side and machine-to-machine applications. Client
    /// secrets are
    /// automatically generated; you can't specify a secret value. For more
    /// information,
    /// see [App client
    /// types](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html#user-pool-settings-client-app-client-types).
    generate_secret: ?bool = null,

    /// The ID token time limit. After this limit expires, your user can't use
    /// their ID token. To specify the time unit for `IdTokenValidity` as
    /// `seconds`, `minutes`, `hours`, or `days`,
    /// set a `TokenValidityUnits` value in your API request.
    ///
    /// For example, when you set `IdTokenValidity` as `10` and
    /// `TokenValidityUnits` as `hours`, your user can authenticate their
    /// session with their ID token for 10 hours.
    ///
    /// The default time unit for `IdTokenValidity` in an API request is hours.
    /// *Valid range* is displayed below in seconds.
    ///
    /// If you don't specify otherwise in the configuration of your app client, your
    /// ID
    /// tokens are valid for one hour.
    id_token_validity: ?i32 = null,

    /// A list of allowed logout URLs for managed login authentication. When you
    /// pass
    /// `logout_uri` and `client_id` parameters to
    /// `/logout`, Amazon Cognito signs out your user and redirects them to the
    /// logout
    /// URL. This parameter describes the URLs that you want to be the permitted
    /// targets of
    /// `logout_uri`. A typical use of these URLs is when a user selects "Sign
    /// out" and you redirect them to your public homepage. For more information,
    /// see [Logout
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/logout-endpoint.html).
    logout_ur_ls: ?[]const []const u8 = null,

    /// When `ENABLED`, suppresses messages that might indicate a valid user exists
    /// when someone attempts sign-in. This parameters sets your preference for the
    /// errors and
    /// responses that you want Amazon Cognito APIs to return during authentication,
    /// account
    /// confirmation, and password recovery when the user doesn't exist in the user
    /// pool. When
    /// set to `ENABLED` and the user doesn't exist, authentication returns an error
    /// indicating either the username or password was incorrect. Account
    /// confirmation and
    /// password recovery return a response indicating a code was sent to a
    /// simulated
    /// destination. When set to `LEGACY`, those APIs return a
    /// `UserNotFoundException` exception if the user doesn't exist in the user
    /// pool.
    ///
    /// Defaults to `LEGACY`.
    prevent_user_existence_errors: ?PreventUserExistenceErrorTypes = null,

    /// The list of user attributes that you want your app client to have read
    /// access to.
    /// After your user authenticates in your app, their access token authorizes
    /// them to read
    /// their own attribute value for any attribute in this list.
    ///
    /// When you don't specify the `ReadAttributes` for your app client, your
    /// app can read the values of `email_verified`,
    /// `phone_number_verified`, and the standard attributes of your user pool.
    /// When your user pool app client has read access to these default attributes,
    /// `ReadAttributes` doesn't return any information. Amazon Cognito only
    /// populates `ReadAttributes` in the API response if you have specified your
    /// own
    /// custom set of read attributes.
    read_attributes: ?[]const []const u8 = null,

    /// The configuration of your app client for refresh token rotation. When
    /// enabled, your
    /// app client issues new ID, access, and refresh tokens when users renew their
    /// sessions
    /// with refresh tokens. When disabled, token refresh issues only ID and access
    /// tokens.
    refresh_token_rotation: ?RefreshTokenRotationType = null,

    /// The refresh token time limit. After this limit expires, your user can't use
    /// their refresh token. To specify the time unit for `RefreshTokenValidity` as
    /// `seconds`, `minutes`, `hours`, or `days`,
    /// set a `TokenValidityUnits` value in your API request.
    ///
    /// For example, when you set `RefreshTokenValidity` as `10` and
    /// `TokenValidityUnits` as `days`, your user can refresh their session
    /// and retrieve new access and ID tokens for 10 days.
    ///
    /// The default time unit for `RefreshTokenValidity` in an API request is days.
    /// You can't set `RefreshTokenValidity` to 0. If you do, Amazon Cognito
    /// overrides the
    /// value with the default value of 30 days. *Valid range* is displayed below
    /// in seconds.
    ///
    /// If you don't specify otherwise in the configuration of your app client, your
    /// refresh
    /// tokens are valid for 30 days.
    refresh_token_validity: ?i32 = null,

    /// A list of provider names for the identity providers (IdPs) that are
    /// supported on this
    /// client. The following are supported: `COGNITO`, `Facebook`,
    /// `Google`, `SignInWithApple`, and `LoginWithAmazon`.
    /// You can also specify the names that you configured for the SAML and OIDC
    /// IdPs in your
    /// user pool, for example `MySAMLIdP` or `MyOIDCIdP`.
    ///
    /// This parameter sets the IdPs that [managed
    /// login](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html) will display on the login page for your app client. The removal of
    /// `COGNITO` from this list doesn't prevent authentication operations
    /// for local users with the user pools API in an Amazon Web Services SDK. The
    /// only way to prevent
    /// SDK-based authentication is to block access with a [WAF
    /// rule](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-waf.html).
    supported_identity_providers: ?[]const []const u8 = null,

    /// The units that validity times are represented in. The default unit for
    /// refresh tokens
    /// is days, and the default for ID and access tokens are hours.
    token_validity_units: ?TokenValidityUnitsType = null,

    /// The ID of the user pool where you want to create an app client.
    user_pool_id: []const u8,

    /// The list of user attributes that you want your app client to have write
    /// access to.
    /// After your user authenticates in your app, their access token authorizes
    /// them to set or
    /// modify their own attribute value for any attribute in this list.
    ///
    /// When you don't specify the `WriteAttributes` for your app client, your
    /// app can write the values of the Standard attributes of your user pool. When
    /// your user
    /// pool has write access to these default attributes, `WriteAttributes`
    /// doesn't return any information. Amazon Cognito only populates
    /// `WriteAttributes` in the API response if you have specified your own
    /// custom set of write attributes.
    ///
    /// If your app client allows users to sign in through an IdP, this array must
    /// include all
    /// attributes that you have mapped to IdP attributes. Amazon Cognito updates
    /// mapped attributes when
    /// users sign in to your application through an IdP. If your app client does
    /// not have write
    /// access to a mapped attribute, Amazon Cognito throws an error when it tries
    /// to update the
    /// attribute. For more information, see [Specifying IdP Attribute Mappings for
    /// Your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-specifying-attribute-mapping.html).
    write_attributes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .access_token_validity = "AccessTokenValidity",
        .allowed_o_auth_flows = "AllowedOAuthFlows",
        .allowed_o_auth_flows_user_pool_client = "AllowedOAuthFlowsUserPoolClient",
        .allowed_o_auth_scopes = "AllowedOAuthScopes",
        .analytics_configuration = "AnalyticsConfiguration",
        .auth_session_validity = "AuthSessionValidity",
        .callback_ur_ls = "CallbackURLs",
        .client_name = "ClientName",
        .default_redirect_uri = "DefaultRedirectURI",
        .enable_propagate_additional_user_context_data = "EnablePropagateAdditionalUserContextData",
        .enable_token_revocation = "EnableTokenRevocation",
        .explicit_auth_flows = "ExplicitAuthFlows",
        .generate_secret = "GenerateSecret",
        .id_token_validity = "IdTokenValidity",
        .logout_ur_ls = "LogoutURLs",
        .prevent_user_existence_errors = "PreventUserExistenceErrors",
        .read_attributes = "ReadAttributes",
        .refresh_token_rotation = "RefreshTokenRotation",
        .refresh_token_validity = "RefreshTokenValidity",
        .supported_identity_providers = "SupportedIdentityProviders",
        .token_validity_units = "TokenValidityUnits",
        .user_pool_id = "UserPoolId",
        .write_attributes = "WriteAttributes",
    };
};

pub const CreateUserPoolClientOutput = struct {
    /// The details of the new app client.
    user_pool_client: ?UserPoolClientType = null,

    pub const json_field_names = .{
        .user_pool_client = "UserPoolClient",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserPoolClientInput, options: CallOptions) !CreateUserPoolClientOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserPoolClientInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateUserPoolClient");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserPoolClientOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUserPoolClientOutput, body, allocator);
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
