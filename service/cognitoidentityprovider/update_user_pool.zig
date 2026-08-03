const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AccountRecoverySettingType = @import("account_recovery_setting_type.zig").AccountRecoverySettingType;
const AdminCreateUserConfigType = @import("admin_create_user_config_type.zig").AdminCreateUserConfigType;
const VerifiedAttributeType = @import("verified_attribute_type.zig").VerifiedAttributeType;
const DeletionProtectionType = @import("deletion_protection_type.zig").DeletionProtectionType;
const DeviceConfigurationType = @import("device_configuration_type.zig").DeviceConfigurationType;
const EmailConfigurationType = @import("email_configuration_type.zig").EmailConfigurationType;
const LambdaConfigType = @import("lambda_config_type.zig").LambdaConfigType;
const UserPoolMfaType = @import("user_pool_mfa_type.zig").UserPoolMfaType;
const UserPoolPolicyType = @import("user_pool_policy_type.zig").UserPoolPolicyType;
const SmsConfigurationType = @import("sms_configuration_type.zig").SmsConfigurationType;
const UserAttributeUpdateSettingsType = @import("user_attribute_update_settings_type.zig").UserAttributeUpdateSettingsType;
const UserPoolAddOnsType = @import("user_pool_add_ons_type.zig").UserPoolAddOnsType;
const UserPoolTierType = @import("user_pool_tier_type.zig").UserPoolTierType;
const VerificationMessageTemplateType = @import("verification_message_template_type.zig").VerificationMessageTemplateType;

pub const UpdateUserPoolInput = struct {
    /// The available verified method a user can use to recover their password when
    /// they call
    /// `ForgotPassword`. You can use this setting to define a preferred method
    /// when a user has more than one method available. With this setting, SMS
    /// doesn't qualify
    /// for a valid password recovery mechanism if the user also has SMS
    /// multi-factor
    /// authentication (MFA) activated. In the absence of this setting, Amazon
    /// Cognito uses the legacy
    /// behavior to determine the recovery method where SMS is preferred through
    /// email.
    account_recovery_setting: ?AccountRecoverySettingType = null,

    /// The configuration for administrative creation of users. Includes the
    /// template for the
    /// invitation message for new users, the duration of temporary passwords, and
    /// permitting
    /// self-service sign-up.
    admin_create_user_config: ?AdminCreateUserConfigType = null,

    /// The attributes that you want your user pool to automatically verify.
    /// Possible values:
    /// **email**, **phone_number**. For more information see [Verifying contact
    /// information at
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
    /// preferred sending method, Amazon Web Services Region, and sender for email
    /// invitation and verification
    /// messages from your user pool.
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

    /// The updated name of your user pool.
    pool_name: ?[]const u8 = null,

    /// The contents of the SMS message that your user pool sends to users in SMS
    /// authentication.
    sms_authentication_message: ?[]const u8 = null,

    /// The SMS configuration with the settings for your Amazon Cognito user pool to
    /// send SMS message
    /// with Amazon Simple Notification Service. To send SMS messages with Amazon
    /// SNS in the Amazon Web Services Region that you want, the
    /// Amazon Cognito user pool uses an Identity and Access Management (IAM) role
    /// in your Amazon Web Services account. For
    /// more information see [SMS message
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

    /// The ID of the user pool you want to update.
    user_pool_id: []const u8,

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
        .sms_authentication_message = "SmsAuthenticationMessage",
        .sms_configuration = "SmsConfiguration",
        .sms_verification_message = "SmsVerificationMessage",
        .user_attribute_update_settings = "UserAttributeUpdateSettings",
        .user_pool_add_ons = "UserPoolAddOns",
        .user_pool_id = "UserPoolId",
        .user_pool_tags = "UserPoolTags",
        .user_pool_tier = "UserPoolTier",
        .verification_message_template = "VerificationMessageTemplate",
    };
};

pub const UpdateUserPoolOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserPoolInput, options: CallOptions) !UpdateUserPoolOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserPoolInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateUserPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserPoolOutput {
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
