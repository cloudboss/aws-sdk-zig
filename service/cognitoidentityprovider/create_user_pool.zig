const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccountRecoverySettingType = @import("account_recovery_setting_type.zig").AccountRecoverySettingType;
const AdminCreateUserConfigType = @import("admin_create_user_config_type.zig").AdminCreateUserConfigType;
const AliasAttributeType = @import("alias_attribute_type.zig").AliasAttributeType;
const VerifiedAttributeType = @import("verified_attribute_type.zig").VerifiedAttributeType;
const DeletionProtectionType = @import("deletion_protection_type.zig").DeletionProtectionType;
const DeviceConfigurationType = @import("device_configuration_type.zig").DeviceConfigurationType;
const EmailConfigurationType = @import("email_configuration_type.zig").EmailConfigurationType;
const LambdaConfigType = @import("lambda_config_type.zig").LambdaConfigType;
const UserPoolMfaType = @import("user_pool_mfa_type.zig").UserPoolMfaType;
const UserPoolPolicyType = @import("user_pool_policy_type.zig").UserPoolPolicyType;
const SchemaAttributeType = @import("schema_attribute_type.zig").SchemaAttributeType;
const SmsConfigurationType = @import("sms_configuration_type.zig").SmsConfigurationType;
const UserAttributeUpdateSettingsType = @import("user_attribute_update_settings_type.zig").UserAttributeUpdateSettingsType;
const UsernameAttributeType = @import("username_attribute_type.zig").UsernameAttributeType;
const UsernameConfigurationType = @import("username_configuration_type.zig").UsernameConfigurationType;
const UserPoolAddOnsType = @import("user_pool_add_ons_type.zig").UserPoolAddOnsType;
const UserPoolTierType = @import("user_pool_tier_type.zig").UserPoolTierType;
const VerificationMessageTemplateType = @import("verification_message_template_type.zig").VerificationMessageTemplateType;
const UserPoolType = @import("user_pool_type.zig").UserPoolType;

pub const CreateUserPoolInput = struct {
    /// The available verified method a user can use to recover their password when
    /// they call
    /// `ForgotPassword`. You can use this setting to define a preferred method
    /// when a user has more than one method available. With this setting, SMS
    /// doesn't qualify
    /// for a valid password recovery mechanism if the user also has SMS
    /// multi-factor
    /// authentication (MFA) activated. Email MFA is also disqualifying for account
    /// recovery
    /// with email. In the absence of this setting, Amazon Cognito uses the legacy
    /// behavior to determine
    /// the recovery method where SMS is preferred over email.
    ///
    /// As a best practice, configure both `verified_email` and
    /// `verified_phone_number`, with one having a higher priority than the
    /// other.
    account_recovery_setting: ?AccountRecoverySettingType = null,

    /// The configuration for administrative creation of users. Includes the
    /// template for the
    /// invitation message for new users, the duration of temporary passwords, and
    /// permitting
    /// self-service sign-up.
    admin_create_user_config: ?AdminCreateUserConfigType = null,

    /// Attributes supported as an alias for this user pool. For more information
    /// about alias
    /// attributes, see [Customizing sign-in
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-aliases).
    alias_attributes: ?[]const AliasAttributeType = null,

    /// The attributes that you want your user pool to automatically verify. For
    /// more
    /// information, see [Verifying contact information at
    /// sign-up](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#allowing-users-to-sign-up-and-confirm-themselves).
    auto_verified_attributes: ?[]const VerifiedAttributeType = null,

    /// When active, `DeletionProtection` prevents accidental deletion of your user
    /// pool. Before you can delete a user pool that you have protected against
    /// deletion, you
    /// must deactivate this feature.
    ///
    /// When you try to delete a protected user pool in a `DeleteUserPool` API
    /// request,
    /// Amazon Cognito returns an `InvalidParameterException` error. To delete a
    /// protected user pool,
    /// send a new `DeleteUserPool` request after you deactivate deletion protection
    /// in an
    /// `UpdateUserPool` API request.
    deletion_protection: ?DeletionProtectionType = null,

    /// The device-remembering configuration for a user pool. Device remembering or
    /// device
    /// tracking is a "Remember me on this device" option for user pools that
    /// perform
    /// authentication with the device key of a trusted device in the back end,
    /// instead of a
    /// user-provided MFA code. For more information about device authentication,
    /// see [Working with user devices in your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html). A null value indicates that
    /// you have deactivated device remembering in your user pool.
    ///
    /// When you provide a value for any `DeviceConfiguration` field, you
    /// activate the Amazon Cognito device-remembering feature. For more
    /// information, see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    device_configuration: ?DeviceConfigurationType = null,

    /// The email configuration of your user pool. The email configuration type sets
    /// your
    /// preferred sending method, Amazon Web Services Region, and sender for
    /// messages from your user
    /// pool.
    email_configuration: ?EmailConfigurationType = null,

    /// This parameter is no longer used.
    email_verification_message: ?[]const u8 = null,

    /// This parameter is no longer used.
    email_verification_subject: ?[]const u8 = null,

    /// A collection of user pool Lambda triggers. Amazon Cognito invokes triggers
    /// at several possible
    /// stages of authentication operations. Triggers can modify the outcome of the
    /// operations
    /// that invoked them.
    lambda_config: ?LambdaConfigType = null,

    /// Sets multi-factor authentication (MFA) to be on, off, or optional. When
    /// `ON`, all users must set up MFA before they can sign in. When
    /// `OPTIONAL`, your application must make a client-side determination of
    /// whether a user wants to register an MFA device. For user pools with adaptive
    /// authentication with threat protection, choose `OPTIONAL`.
    ///
    /// When `MfaConfiguration` is `OPTIONAL`, managed login
    /// doesn't automatically prompt users to set up MFA. Amazon Cognito generates
    /// MFA prompts in
    /// API responses and in managed login for users who have chosen and configured
    /// a preferred
    /// MFA factor.
    mfa_configuration: ?UserPoolMfaType = null,

    /// The password policy and sign-in policy in the user pool. The password policy
    /// sets
    /// options like password complexity requirements and password history. The
    /// sign-in policy
    /// sets the options available to applications in [choice-based
    /// authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flows-selection-sdk.html#authentication-flows-selection-choice).
    policies: ?UserPoolPolicyType = null,

    /// A friendly name for your user pool.
    pool_name: []const u8,

    /// An array of attributes for the new user pool. You can add custom attributes
    /// and modify
    /// the properties of default attributes. The specifications in this parameter
    /// set the
    /// required attributes in your user pool. For more information, see [Working
    /// with user
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html).
    schema: ?[]const SchemaAttributeType = null,

    /// The contents of the SMS message that your user pool sends to users in SMS
    /// OTP and MFA
    /// authentication.
    sms_authentication_message: ?[]const u8 = null,

    /// The settings for your Amazon Cognito user pool to send SMS messages with
    /// Amazon Simple Notification Service. To send SMS
    /// messages with Amazon SNS in the Amazon Web Services Region that you want,
    /// the Amazon Cognito user pool uses an
    /// Identity and Access Management (IAM) role in your Amazon Web Services
    /// account. For more information see
    /// [SMS message
    /// settings](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html).
    sms_configuration: ?SmsConfigurationType = null,

    /// This parameter is no longer used.
    sms_verification_message: ?[]const u8 = null,

    /// The settings for updates to user attributes. These settings include the
    /// property `AttributesRequireVerificationBeforeUpdate`,
    /// a user-pool setting that tells Amazon Cognito how to handle changes to the
    /// value of your users' email address and phone number attributes. For
    /// more information, see [
    /// Verifying updates to email addresses and phone
    /// numbers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates).
    user_attribute_update_settings: ?UserAttributeUpdateSettingsType = null,

    /// Specifies whether a user can use an email address or phone number as a
    /// username when
    /// they sign up. For more information, see [Customizing sign-in
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-aliases).
    username_attributes: ?[]const UsernameAttributeType = null,

    /// Sets the case sensitivity option for sign-in usernames. When
    /// `CaseSensitive` is `false` (case insensitive), users can sign
    /// in with any combination of capital and lowercase letters. For example,
    /// `username`, `USERNAME`, or `UserName`, or for
    /// email, `email@example.com` or `EMaiL@eXamplE.Com`. For most use
    /// cases, set case sensitivity to `false` as a best practice. When usernames
    /// and
    /// email addresses are case insensitive, Amazon Cognito treats any variation in
    /// case as the same
    /// user, and prevents a case variation from being assigned to the same
    /// attribute for a
    /// different user.
    ///
    /// When `CaseSensitive` is `true` (case sensitive), Amazon Cognito
    /// interprets `USERNAME` and `UserName` as distinct users.
    ///
    /// This configuration is immutable after you set it.
    username_configuration: ?UsernameConfigurationType = null,

    /// Contains settings for activation of threat protection, including the
    /// operating
    /// mode and additional authentication types. To log user security information
    /// but take
    /// no action, set to `AUDIT`. To configure automatic security responses to
    /// potentially unwanted traffic to your user pool, set to `ENFORCED`.
    ///
    /// For more information, see [Adding advanced security to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html). To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    user_pool_add_ons: ?UserPoolAddOnsType = null,

    /// The tag keys and values to assign to the user pool. A tag is a label that
    /// you can use
    /// to categorize and manage user pools in different ways, such as by purpose,
    /// owner,
    /// environment, or other criteria.
    user_pool_tags: ?[]const aws.map.StringMapEntry = null,

    /// The user pool [feature
    /// plan](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-sign-in-feature-plans.html), or tier. This parameter determines the
    /// eligibility of the user pool for features like managed login, access-token
    /// customization, and threat protection. Defaults to `ESSENTIALS`.
    user_pool_tier: ?UserPoolTierType = null,

    /// The template for the verification message that your user pool delivers to
    /// users who
    /// set an email address or phone number attribute.
    ///
    /// Set the email message type that corresponds to your `DefaultEmailOption`
    /// selection. For `CONFIRM_WITH_LINK`, specify an
    /// `EmailMessageByLink` and leave `EmailMessage` blank. For
    /// `CONFIRM_WITH_CODE`, specify an `EmailMessage` and leave
    /// `EmailMessageByLink` blank. When you supply both parameters with either
    /// choice, Amazon Cognito returns an error.
    verification_message_template: ?VerificationMessageTemplateType = null,

    pub const json_field_names = .{
        .account_recovery_setting = "AccountRecoverySetting",
        .admin_create_user_config = "AdminCreateUserConfig",
        .alias_attributes = "AliasAttributes",
        .auto_verified_attributes = "AutoVerifiedAttributes",
        .deletion_protection = "DeletionProtection",
        .device_configuration = "DeviceConfiguration",
        .email_configuration = "EmailConfiguration",
        .email_verification_message = "EmailVerificationMessage",
        .email_verification_subject = "EmailVerificationSubject",
        .lambda_config = "LambdaConfig",
        .mfa_configuration = "MfaConfiguration",
        .policies = "Policies",
        .pool_name = "PoolName",
        .schema = "Schema",
        .sms_authentication_message = "SmsAuthenticationMessage",
        .sms_configuration = "SmsConfiguration",
        .sms_verification_message = "SmsVerificationMessage",
        .user_attribute_update_settings = "UserAttributeUpdateSettings",
        .username_attributes = "UsernameAttributes",
        .username_configuration = "UsernameConfiguration",
        .user_pool_add_ons = "UserPoolAddOns",
        .user_pool_tags = "UserPoolTags",
        .user_pool_tier = "UserPoolTier",
        .verification_message_template = "VerificationMessageTemplate",
    };
};

pub const CreateUserPoolOutput = struct {
    /// The details of the created user pool.
    user_pool: ?UserPoolType = null,

    pub const json_field_names = .{
        .user_pool = "UserPool",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserPoolInput, options: Options) !CreateUserPoolOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognitoidentityprovider", "Cognito Identity Provider", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateUserPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserPoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUserPoolOutput, body, allocator);
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
