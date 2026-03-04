const aws = @import("aws");
const std = @import("std");

const add_custom_attributes = @import("add_custom_attributes.zig");
const admin_add_user_to_group = @import("admin_add_user_to_group.zig");
const admin_confirm_sign_up = @import("admin_confirm_sign_up.zig");
const admin_create_user = @import("admin_create_user.zig");
const admin_delete_user = @import("admin_delete_user.zig");
const admin_delete_user_attributes = @import("admin_delete_user_attributes.zig");
const admin_disable_provider_for_user = @import("admin_disable_provider_for_user.zig");
const admin_disable_user = @import("admin_disable_user.zig");
const admin_enable_user = @import("admin_enable_user.zig");
const admin_forget_device = @import("admin_forget_device.zig");
const admin_get_device = @import("admin_get_device.zig");
const admin_get_user = @import("admin_get_user.zig");
const admin_initiate_auth = @import("admin_initiate_auth.zig");
const admin_link_provider_for_user = @import("admin_link_provider_for_user.zig");
const admin_list_devices = @import("admin_list_devices.zig");
const admin_list_groups_for_user = @import("admin_list_groups_for_user.zig");
const admin_list_user_auth_events = @import("admin_list_user_auth_events.zig");
const admin_remove_user_from_group = @import("admin_remove_user_from_group.zig");
const admin_reset_user_password = @import("admin_reset_user_password.zig");
const admin_respond_to_auth_challenge = @import("admin_respond_to_auth_challenge.zig");
const admin_set_user_mfa_preference = @import("admin_set_user_mfa_preference.zig");
const admin_set_user_password = @import("admin_set_user_password.zig");
const admin_set_user_settings = @import("admin_set_user_settings.zig");
const admin_update_auth_event_feedback = @import("admin_update_auth_event_feedback.zig");
const admin_update_device_status = @import("admin_update_device_status.zig");
const admin_update_user_attributes = @import("admin_update_user_attributes.zig");
const admin_user_global_sign_out = @import("admin_user_global_sign_out.zig");
const associate_software_token = @import("associate_software_token.zig");
const change_password = @import("change_password.zig");
const complete_web_authn_registration = @import("complete_web_authn_registration.zig");
const confirm_device = @import("confirm_device.zig");
const confirm_forgot_password = @import("confirm_forgot_password.zig");
const confirm_sign_up = @import("confirm_sign_up.zig");
const create_group = @import("create_group.zig");
const create_identity_provider = @import("create_identity_provider.zig");
const create_managed_login_branding = @import("create_managed_login_branding.zig");
const create_resource_server = @import("create_resource_server.zig");
const create_terms = @import("create_terms.zig");
const create_user_import_job = @import("create_user_import_job.zig");
const create_user_pool = @import("create_user_pool.zig");
const create_user_pool_client = @import("create_user_pool_client.zig");
const create_user_pool_domain = @import("create_user_pool_domain.zig");
const delete_group = @import("delete_group.zig");
const delete_identity_provider = @import("delete_identity_provider.zig");
const delete_managed_login_branding = @import("delete_managed_login_branding.zig");
const delete_resource_server = @import("delete_resource_server.zig");
const delete_terms = @import("delete_terms.zig");
const delete_user = @import("delete_user.zig");
const delete_user_attributes = @import("delete_user_attributes.zig");
const delete_user_pool = @import("delete_user_pool.zig");
const delete_user_pool_client = @import("delete_user_pool_client.zig");
const delete_user_pool_domain = @import("delete_user_pool_domain.zig");
const delete_web_authn_credential = @import("delete_web_authn_credential.zig");
const describe_identity_provider = @import("describe_identity_provider.zig");
const describe_managed_login_branding = @import("describe_managed_login_branding.zig");
const describe_managed_login_branding_by_client = @import("describe_managed_login_branding_by_client.zig");
const describe_resource_server = @import("describe_resource_server.zig");
const describe_risk_configuration = @import("describe_risk_configuration.zig");
const describe_terms = @import("describe_terms.zig");
const describe_user_import_job = @import("describe_user_import_job.zig");
const describe_user_pool = @import("describe_user_pool.zig");
const describe_user_pool_client = @import("describe_user_pool_client.zig");
const describe_user_pool_domain = @import("describe_user_pool_domain.zig");
const forget_device = @import("forget_device.zig");
const forgot_password = @import("forgot_password.zig");
const get_csv_header = @import("get_csv_header.zig");
const get_device = @import("get_device.zig");
const get_group = @import("get_group.zig");
const get_identity_provider_by_identifier = @import("get_identity_provider_by_identifier.zig");
const get_log_delivery_configuration = @import("get_log_delivery_configuration.zig");
const get_signing_certificate = @import("get_signing_certificate.zig");
const get_tokens_from_refresh_token = @import("get_tokens_from_refresh_token.zig");
const get_ui_customization = @import("get_ui_customization.zig");
const get_user = @import("get_user.zig");
const get_user_attribute_verification_code = @import("get_user_attribute_verification_code.zig");
const get_user_auth_factors = @import("get_user_auth_factors.zig");
const get_user_pool_mfa_config = @import("get_user_pool_mfa_config.zig");
const global_sign_out = @import("global_sign_out.zig");
const initiate_auth = @import("initiate_auth.zig");
const list_devices = @import("list_devices.zig");
const list_groups = @import("list_groups.zig");
const list_identity_providers = @import("list_identity_providers.zig");
const list_resource_servers = @import("list_resource_servers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_terms = @import("list_terms.zig");
const list_user_import_jobs = @import("list_user_import_jobs.zig");
const list_user_pool_clients = @import("list_user_pool_clients.zig");
const list_user_pools = @import("list_user_pools.zig");
const list_users = @import("list_users.zig");
const list_users_in_group = @import("list_users_in_group.zig");
const list_web_authn_credentials = @import("list_web_authn_credentials.zig");
const resend_confirmation_code = @import("resend_confirmation_code.zig");
const respond_to_auth_challenge = @import("respond_to_auth_challenge.zig");
const revoke_token = @import("revoke_token.zig");
const set_log_delivery_configuration = @import("set_log_delivery_configuration.zig");
const set_risk_configuration = @import("set_risk_configuration.zig");
const set_ui_customization = @import("set_ui_customization.zig");
const set_user_mfa_preference = @import("set_user_mfa_preference.zig");
const set_user_pool_mfa_config = @import("set_user_pool_mfa_config.zig");
const set_user_settings = @import("set_user_settings.zig");
const sign_up = @import("sign_up.zig");
const start_user_import_job = @import("start_user_import_job.zig");
const start_web_authn_registration = @import("start_web_authn_registration.zig");
const stop_user_import_job = @import("stop_user_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_auth_event_feedback = @import("update_auth_event_feedback.zig");
const update_device_status = @import("update_device_status.zig");
const update_group = @import("update_group.zig");
const update_identity_provider = @import("update_identity_provider.zig");
const update_managed_login_branding = @import("update_managed_login_branding.zig");
const update_resource_server = @import("update_resource_server.zig");
const update_terms = @import("update_terms.zig");
const update_user_attributes = @import("update_user_attributes.zig");
const update_user_pool = @import("update_user_pool.zig");
const update_user_pool_client = @import("update_user_pool_client.zig");
const update_user_pool_domain = @import("update_user_pool_domain.zig");
const verify_software_token = @import("verify_software_token.zig");
const verify_user_attribute = @import("verify_user_attribute.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cognito Identity Provider";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds additional user attributes to the user pool schema. Custom attributes
    /// can be
    /// mutable or immutable and have a `custom:` or `dev:` prefix. For
    /// more information, see [Custom
    /// attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-custom-attributes).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn addCustomAttributes(self: *Self, allocator: std.mem.Allocator, input: add_custom_attributes.AddCustomAttributesInput, options: CallOptions) !add_custom_attributes.AddCustomAttributesOutput {
        return add_custom_attributes.execute(self, allocator, input, options);
    }

    /// Adds a user to a group. A user who is in a group can present a
    /// preferred-role claim to
    /// an identity pool, and populates a `cognito:groups` claim to their access and
    /// identity tokens.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminAddUserToGroup(self: *Self, allocator: std.mem.Allocator, input: admin_add_user_to_group.AdminAddUserToGroupInput, options: CallOptions) !admin_add_user_to_group.AdminAddUserToGroupOutput {
        return admin_add_user_to_group.execute(self, allocator, input, options);
    }

    /// Confirms user sign-up as an administrator.
    ///
    /// This request sets a user account active in a user pool that [requires
    /// confirmation of new user
    /// accounts](https://docs.aws.amazon.com/cognito/latest/developerguide/signing-up-users-in-your-app.html#signing-up-users-in-your-app-and-confirming-them-as-admin) before they can sign in. You can
    /// configure your user pool to not send confirmation codes to new users and
    /// instead confirm
    /// them with this API operation on the back end.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    ///
    /// To configure your user pool to require administrative confirmation of users,
    /// set
    /// `AllowAdminCreateUserOnly` to `true` in a
    /// `CreateUserPool` or `UpdateUserPool` request.
    pub fn adminConfirmSignUp(self: *Self, allocator: std.mem.Allocator, input: admin_confirm_sign_up.AdminConfirmSignUpInput, options: CallOptions) !admin_confirm_sign_up.AdminConfirmSignUpOutput {
        return admin_confirm_sign_up.execute(self, allocator, input, options);
    }

    /// Creates a new user in the specified user pool.
    ///
    /// If `MessageAction` isn't set, the default is to send a welcome message via
    /// email or phone (SMS).
    ///
    /// This message is based on a template that you configured in your call to
    /// create or
    /// update a user pool. This template includes your custom sign-up instructions
    /// and
    /// placeholders for user name and temporary password.
    ///
    /// Alternatively, you can call `AdminCreateUser` with `SUPPRESS`
    /// for the `MessageAction` parameter, and Amazon Cognito won't send any email.
    ///
    /// In either case, if the user has a password, they will be in the
    /// `FORCE_CHANGE_PASSWORD` state until they sign in and set their password.
    /// Your invitation message template must have the `{####}` password placeholder
    /// if your users have passwords. If your template doesn't have this
    /// placeholder, Amazon Cognito
    /// doesn't deliver the invitation message. In this case, you must update your
    /// message
    /// template and resend the password with a new `AdminCreateUser` request with a
    /// `MessageAction` value of `RESEND`.
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminCreateUser(self: *Self, allocator: std.mem.Allocator, input: admin_create_user.AdminCreateUserInput, options: CallOptions) !admin_create_user.AdminCreateUserOutput {
        return admin_create_user.execute(self, allocator, input, options);
    }

    /// Deletes a user profile in your user pool.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminDeleteUser(self: *Self, allocator: std.mem.Allocator, input: admin_delete_user.AdminDeleteUserInput, options: CallOptions) !admin_delete_user.AdminDeleteUserOutput {
        return admin_delete_user.execute(self, allocator, input, options);
    }

    /// Deletes attribute values from a user. This operation doesn't affect tokens
    /// for
    /// existing user sessions. The next ID token that the user receives will no
    /// longer have the
    /// deleted attributes.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminDeleteUserAttributes(self: *Self, allocator: std.mem.Allocator, input: admin_delete_user_attributes.AdminDeleteUserAttributesInput, options: CallOptions) !admin_delete_user_attributes.AdminDeleteUserAttributesOutput {
        return admin_delete_user_attributes.execute(self, allocator, input, options);
    }

    /// Prevents the user from signing in with the specified external (SAML or
    /// social)
    /// identity provider (IdP). If the user that you want to deactivate is a Amazon
    /// Cognito user pools
    /// native username + password user, they can't use their password to sign in.
    /// If the user
    /// to deactivate is a linked external IdP user, any link between that user and
    /// an existing
    /// user is removed. When the external user signs in again, and the user is no
    /// longer
    /// attached to the previously linked `DestinationUser`, the user must create a
    /// new user account.
    ///
    /// The value of `ProviderName` must match the name of a user pool IdP.
    ///
    /// To deactivate a local user, set `ProviderName` to `Cognito` and
    /// the `ProviderAttributeName` to `Cognito_Subject`. The
    /// `ProviderAttributeValue` must be user's local username.
    ///
    /// The `ProviderAttributeName` must always be `Cognito_Subject` for
    /// social IdPs. The `ProviderAttributeValue` must always be the exact subject
    /// that was used when the user was originally linked as a source user.
    ///
    /// For de-linking a SAML identity, there are two scenarios. If the linked
    /// identity has
    /// not yet been used to sign in, the `ProviderAttributeName` and
    /// `ProviderAttributeValue` must be the same values that were used for the
    /// `SourceUser` when the identities were originally linked using `
    /// AdminLinkProviderForUser` call. This is also true if the linking was done
    /// with
    /// `ProviderAttributeName` set to `Cognito_Subject`. If the user
    /// has already signed in, the `ProviderAttributeName` must be
    /// `Cognito_Subject` and `ProviderAttributeValue` must be the
    /// `NameID` from their SAML assertion.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminDisableProviderForUser(self: *Self, allocator: std.mem.Allocator, input: admin_disable_provider_for_user.AdminDisableProviderForUserInput, options: CallOptions) !admin_disable_provider_for_user.AdminDisableProviderForUserOutput {
        return admin_disable_provider_for_user.execute(self, allocator, input, options);
    }

    /// Deactivates a user profile and revokes all access tokens for the user. A
    /// deactivated
    /// user can't sign in, but still appears in the responses to `ListUsers`
    /// API requests.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminDisableUser(self: *Self, allocator: std.mem.Allocator, input: admin_disable_user.AdminDisableUserInput, options: CallOptions) !admin_disable_user.AdminDisableUserOutput {
        return admin_disable_user.execute(self, allocator, input, options);
    }

    /// Activates sign-in for a user profile that previously had sign-in access
    /// disabled.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminEnableUser(self: *Self, allocator: std.mem.Allocator, input: admin_enable_user.AdminEnableUserInput, options: CallOptions) !admin_enable_user.AdminEnableUserOutput {
        return admin_enable_user.execute(self, allocator, input, options);
    }

    /// Forgets, or deletes, a remembered device from a user's profile. After you
    /// forget
    /// the device, the user can no longer complete device authentication with that
    /// device and
    /// when applicable, must submit MFA codes again. For more information, see
    /// [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminForgetDevice(self: *Self, allocator: std.mem.Allocator, input: admin_forget_device.AdminForgetDeviceInput, options: CallOptions) !admin_forget_device.AdminForgetDeviceOutput {
        return admin_forget_device.execute(self, allocator, input, options);
    }

    /// Given the device key, returns details for a user's device. For more
    /// information,
    /// see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminGetDevice(self: *Self, allocator: std.mem.Allocator, input: admin_get_device.AdminGetDeviceInput, options: CallOptions) !admin_get_device.AdminGetDeviceOutput {
        return admin_get_device.execute(self, allocator, input, options);
    }

    /// Given a username, returns details about a user profile in a user pool. You
    /// can specify
    /// alias attributes in the `Username` request parameter.
    ///
    /// This operation contributes to your monthly active user (MAU) count for the
    /// purpose of
    /// billing.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminGetUser(self: *Self, allocator: std.mem.Allocator, input: admin_get_user.AdminGetUserInput, options: CallOptions) !admin_get_user.AdminGetUserOutput {
        return admin_get_user.execute(self, allocator, input, options);
    }

    /// Starts sign-in for applications with a server-side component, for example a
    /// traditional web application. This operation specifies the authentication
    /// flow that
    /// you'd like to begin. The authentication flow that you specify must be
    /// supported in
    /// your app client configuration. For more information about authentication
    /// flows, see
    /// [Authentication
    /// flows](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow-methods.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminInitiateAuth(self: *Self, allocator: std.mem.Allocator, input: admin_initiate_auth.AdminInitiateAuthInput, options: CallOptions) !admin_initiate_auth.AdminInitiateAuthOutput {
        return admin_initiate_auth.execute(self, allocator, input, options);
    }

    /// Links an existing user account in a user pool, or `DestinationUser`, to an
    /// identity from an external IdP, or `SourceUser`, based on a specified
    /// attribute name and value from the external IdP.
    ///
    /// This operation connects a local user profile with a user identity who hasn't
    /// yet
    /// signed in from their third-party IdP. When the user signs in with their IdP,
    /// they get
    /// access-control configuration from the local user profile. Linked local users
    /// can also
    /// sign in with SDK-based API operations like `InitiateAuth` after they sign in
    /// at least once through their IdP. For more information, see [Linking
    /// federated
    /// users](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation-consolidate-users.html).
    ///
    /// The maximum number of federated identities linked to a user is five.
    ///
    /// Because this API allows a user with an external federated identity to sign
    /// in as a
    /// local user, it is critical that it only be used with external IdPs and
    /// linked
    /// attributes that you trust.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminLinkProviderForUser(self: *Self, allocator: std.mem.Allocator, input: admin_link_provider_for_user.AdminLinkProviderForUserInput, options: CallOptions) !admin_link_provider_for_user.AdminLinkProviderForUserOutput {
        return admin_link_provider_for_user.execute(self, allocator, input, options);
    }

    /// Lists a user's registered devices. Remembered devices are used in
    /// authentication
    /// services where you offer a "Remember me" option for users who you want to
    /// permit to sign
    /// in without MFA from a trusted device. Users can bypass MFA while your
    /// application
    /// performs device SRP authentication on the back end. For more information,
    /// see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminListDevices(self: *Self, allocator: std.mem.Allocator, input: admin_list_devices.AdminListDevicesInput, options: CallOptions) !admin_list_devices.AdminListDevicesOutput {
        return admin_list_devices.execute(self, allocator, input, options);
    }

    /// Lists the groups that a user belongs to. User pool groups are identifiers
    /// that you can
    /// reference from the contents of ID and access tokens, and set preferred IAM
    /// roles for
    /// identity-pool authentication. For more information, see [Adding groups to a
    /// user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminListGroupsForUser(self: *Self, allocator: std.mem.Allocator, input: admin_list_groups_for_user.AdminListGroupsForUserInput, options: CallOptions) !admin_list_groups_for_user.AdminListGroupsForUserOutput {
        return admin_list_groups_for_user.execute(self, allocator, input, options);
    }

    /// Requests a history of user activity and any risks detected as part of Amazon
    /// Cognito threat
    /// protection. For more information, see [Viewing user event
    /// history](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-event-user-history).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminListUserAuthEvents(self: *Self, allocator: std.mem.Allocator, input: admin_list_user_auth_events.AdminListUserAuthEventsInput, options: CallOptions) !admin_list_user_auth_events.AdminListUserAuthEventsOutput {
        return admin_list_user_auth_events.execute(self, allocator, input, options);
    }

    /// Given a username and a group name, removes them from the group. User pool
    /// groups are
    /// identifiers that you can reference from the contents of ID and access
    /// tokens, and set
    /// preferred IAM roles for identity-pool authentication. For more information,
    /// see [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminRemoveUserFromGroup(self: *Self, allocator: std.mem.Allocator, input: admin_remove_user_from_group.AdminRemoveUserFromGroupInput, options: CallOptions) !admin_remove_user_from_group.AdminRemoveUserFromGroupOutput {
        return admin_remove_user_from_group.execute(self, allocator, input, options);
    }

    /// Begins the password reset process. Sets the requested user’s account into a
    /// `RESET_REQUIRED` status, and sends them a password-reset code. Your user
    /// pool also sends the user a notification with a reset code and the
    /// information that their
    /// password has been reset. At sign-in, your application or the managed login
    /// session
    /// receives a challenge to complete the reset by confirming the code and
    /// setting a new
    /// password.
    ///
    /// To use this API operation, your user pool must have self-service account
    /// recovery
    /// configured.
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminResetUserPassword(self: *Self, allocator: std.mem.Allocator, input: admin_reset_user_password.AdminResetUserPasswordInput, options: CallOptions) !admin_reset_user_password.AdminResetUserPasswordOutput {
        return admin_reset_user_password.execute(self, allocator, input, options);
    }

    /// Some API operations in a user pool generate a challenge, like a prompt for
    /// an MFA
    /// code, for device authentication that bypasses MFA, or for a custom
    /// authentication
    /// challenge. An `AdminRespondToAuthChallenge` API request provides the answer
    /// to that challenge, like a code or a secure remote password (SRP). The
    /// parameters of a
    /// response to an authentication challenge vary with the type of challenge.
    ///
    /// For more information about custom authentication challenges, see [Custom
    /// authentication challenge Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminRespondToAuthChallenge(self: *Self, allocator: std.mem.Allocator, input: admin_respond_to_auth_challenge.AdminRespondToAuthChallengeInput, options: CallOptions) !admin_respond_to_auth_challenge.AdminRespondToAuthChallengeOutput {
        return admin_respond_to_auth_challenge.execute(self, allocator, input, options);
    }

    /// Sets the user's multi-factor authentication (MFA) preference, including
    /// which MFA
    /// options are activated, and if any are preferred. Only one factor can be set
    /// as
    /// preferred. The preferred MFA factor will be used to authenticate a user if
    /// multiple
    /// factors are activated. If multiple options are activated and no preference
    /// is set, a
    /// challenge to choose an MFA option will be returned during sign-in.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminSetUserMfaPreference(self: *Self, allocator: std.mem.Allocator, input: admin_set_user_mfa_preference.AdminSetUserMFAPreferenceInput, options: CallOptions) !admin_set_user_mfa_preference.AdminSetUserMFAPreferenceOutput {
        return admin_set_user_mfa_preference.execute(self, allocator, input, options);
    }

    /// Sets the specified user's password in a user pool. This operation
    /// administratively
    /// sets a temporary or permanent password for a user. With this operation, you
    /// can bypass
    /// self-service password changes and permit immediate sign-in with the password
    /// that you
    /// set. To do this, set `Permanent` to `true`.
    ///
    /// You can also set a new temporary password in this request, send it to a
    /// user, and
    /// require them to choose a new password on their next sign-in. To do this, set
    /// `Permanent` to `false`.
    ///
    /// If the password is temporary, the user's `Status` becomes
    /// `FORCE_CHANGE_PASSWORD`. When the user next tries to sign in, the
    /// `InitiateAuth` or `AdminInitiateAuth` response includes the
    /// `NEW_PASSWORD_REQUIRED` challenge. If the user doesn't sign in
    /// before the temporary password expires, they can no longer sign in and you
    /// must repeat
    /// this operation to set a temporary or permanent password for them.
    ///
    /// After the user sets a new password, or if you set a permanent password,
    /// their status
    /// becomes `Confirmed`.
    ///
    /// `AdminSetUserPassword` can set a password for the user profile that Amazon
    /// Cognito
    /// creates for third-party federated users. When you set a password, the
    /// federated user's
    /// status changes from `EXTERNAL_PROVIDER` to `CONFIRMED`. A user in
    /// this state can sign in as a federated user, and initiate authentication
    /// flows in the API
    /// like a linked native user. They can also modify their password and
    /// attributes in
    /// token-authenticated API requests like `ChangePassword` and
    /// `UpdateUserAttributes`. As a best security practice and to keep users in
    /// sync with your external IdP, don't set passwords on federated user profiles.
    /// To set up a
    /// federated user for native sign-in with a linked native user, refer to
    /// [Linking federated users to an existing user
    /// profile](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation-consolidate-users.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminSetUserPassword(self: *Self, allocator: std.mem.Allocator, input: admin_set_user_password.AdminSetUserPasswordInput, options: CallOptions) !admin_set_user_password.AdminSetUserPasswordOutput {
        return admin_set_user_password.execute(self, allocator, input, options);
    }

    /// *This action is no longer supported.* You can use it to configure
    /// only SMS MFA. You can't use it to configure time-based one-time password
    /// (TOTP) software
    /// token MFA.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminSetUserSettings(self: *Self, allocator: std.mem.Allocator, input: admin_set_user_settings.AdminSetUserSettingsInput, options: CallOptions) !admin_set_user_settings.AdminSetUserSettingsOutput {
        return admin_set_user_settings.execute(self, allocator, input, options);
    }

    /// Provides the feedback for an authentication event generated by threat
    /// protection
    /// features. Your response indicates that you think that the event either was
    /// from a valid
    /// user or was an unwanted authentication attempt. This feedback improves the
    /// risk
    /// evaluation decision for the user pool as part of Amazon Cognito threat
    /// protection.
    /// To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    ///
    /// To train the threat-protection model to recognize trusted and untrusted
    /// sign-in
    /// characteristics, configure threat protection in audit-only mode and provide
    /// a mechanism
    /// for users or administrators to submit feedback. Your feedback can tell
    /// Amazon Cognito that a risk
    /// rating was assigned at a level you don't agree with.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminUpdateAuthEventFeedback(self: *Self, allocator: std.mem.Allocator, input: admin_update_auth_event_feedback.AdminUpdateAuthEventFeedbackInput, options: CallOptions) !admin_update_auth_event_feedback.AdminUpdateAuthEventFeedbackOutput {
        return admin_update_auth_event_feedback.execute(self, allocator, input, options);
    }

    /// Updates the status of a user's device so that it is marked as remembered or
    /// not
    /// remembered for the purpose of device authentication. Device authentication
    /// is a
    /// "remember me" mechanism that silently completes sign-in from trusted devices
    /// with a
    /// device key instead of a user-provided MFA code. This operation changes the
    /// status of a
    /// device without deleting it, so you can enable it again later. For more
    /// information about
    /// device authentication, see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminUpdateDeviceStatus(self: *Self, allocator: std.mem.Allocator, input: admin_update_device_status.AdminUpdateDeviceStatusInput, options: CallOptions) !admin_update_device_status.AdminUpdateDeviceStatusOutput {
        return admin_update_device_status.execute(self, allocator, input, options);
    }

    /// Updates the specified user's attributes. To delete an attribute from your
    /// user,
    /// submit the attribute in your API request with a blank value.
    ///
    /// For custom attributes, you must add a `custom:` prefix to the attribute
    /// name, for example `custom:department`.
    ///
    /// This operation can set a user's email address or phone number as verified
    /// and
    /// permit immediate sign-in in user pools that require verification of these
    /// attributes. To
    /// do this, set the `email_verified` or `phone_number_verified`
    /// attribute to `true`.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn adminUpdateUserAttributes(self: *Self, allocator: std.mem.Allocator, input: admin_update_user_attributes.AdminUpdateUserAttributesInput, options: CallOptions) !admin_update_user_attributes.AdminUpdateUserAttributesOutput {
        return admin_update_user_attributes.execute(self, allocator, input, options);
    }

    /// Invalidates the identity, access, and refresh tokens that Amazon Cognito
    /// issued to a user. Call
    /// this operation with your administrative credentials when your user signs out
    /// of your
    /// app. This results in the following behavior.
    ///
    /// * Amazon Cognito no longer accepts *token-authorized* user operations
    /// that you authorize with a signed-out user's access tokens. For more
    /// information,
    /// see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// Amazon Cognito returns an `Access Token has been revoked` error when your
    /// app attempts to authorize a user pools API request with a revoked access
    /// token
    /// that contains the scope `aws.cognito.signin.user.admin`.
    ///
    /// * Amazon Cognito no longer accepts a signed-out user's ID token in a [GetId
    ///   ](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetId.html) request to an identity pool with
    /// `ServerSideTokenCheck` enabled for its user pool IdP
    /// configuration in
    /// [CognitoIdentityProvider](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_CognitoIdentityProvider.html).
    ///
    /// * Amazon Cognito no longer accepts a signed-out user's refresh tokens in
    ///   refresh
    /// requests.
    ///
    /// Other requests might be valid until your user's token expires. This
    /// operation
    /// doesn't clear the [managed
    /// login](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html) session cookie. To clear the session for
    /// a user who signed in with managed login or the classic hosted UI, direct
    /// their browser
    /// session to the [logout
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/logout-endpoint.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn adminUserGlobalSignOut(self: *Self, allocator: std.mem.Allocator, input: admin_user_global_sign_out.AdminUserGlobalSignOutInput, options: CallOptions) !admin_user_global_sign_out.AdminUserGlobalSignOutOutput {
        return admin_user_global_sign_out.execute(self, allocator, input, options);
    }

    /// Begins setup of time-based one-time password (TOTP) multi-factor
    /// authentication (MFA)
    /// for a user, with a unique private key that Amazon Cognito generates and
    /// returns in the API
    /// response. You can authorize an `AssociateSoftwareToken` request with either
    /// the user's access token, or a session string from a challenge response that
    /// you received
    /// from Amazon Cognito.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    pub fn associateSoftwareToken(self: *Self, allocator: std.mem.Allocator, input: associate_software_token.AssociateSoftwareTokenInput, options: CallOptions) !associate_software_token.AssociateSoftwareTokenOutput {
        return associate_software_token.execute(self, allocator, input, options);
    }

    /// Changes the password for the currently signed-in user.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn changePassword(self: *Self, allocator: std.mem.Allocator, input: change_password.ChangePasswordInput, options: CallOptions) !change_password.ChangePasswordOutput {
        return change_password.execute(self, allocator, input, options);
    }

    /// Completes registration of a passkey authenticator for the currently
    /// signed-in
    /// user.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    pub fn completeWebAuthnRegistration(self: *Self, allocator: std.mem.Allocator, input: complete_web_authn_registration.CompleteWebAuthnRegistrationInput, options: CallOptions) !complete_web_authn_registration.CompleteWebAuthnRegistrationOutput {
        return complete_web_authn_registration.execute(self, allocator, input, options);
    }

    /// Confirms a device that a user wants to remember. A remembered device is a
    /// "Remember me
    /// on this device" option for user pools that perform authentication with the
    /// device key of
    /// a trusted device in the back end, instead of a user-provided MFA code. For
    /// more
    /// information about device authentication, see [Working with user devices in
    /// your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn confirmDevice(self: *Self, allocator: std.mem.Allocator, input: confirm_device.ConfirmDeviceInput, options: CallOptions) !confirm_device.ConfirmDeviceOutput {
        return confirm_device.execute(self, allocator, input, options);
    }

    /// This public API operation accepts a confirmation code that Amazon Cognito
    /// sent to a user and
    /// accepts a new password for that user.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn confirmForgotPassword(self: *Self, allocator: std.mem.Allocator, input: confirm_forgot_password.ConfirmForgotPasswordInput, options: CallOptions) !confirm_forgot_password.ConfirmForgotPasswordOutput {
        return confirm_forgot_password.execute(self, allocator, input, options);
    }

    /// Confirms the account of a new user. This public API operation submits a code
    /// that
    /// Amazon Cognito sent to your user when they signed up in your user pool.
    /// After your user enters
    /// their code, they confirm ownership of the email address or phone number that
    /// they
    /// provided, and their user account becomes active. Depending on your user pool
    /// configuration, your users will receive their confirmation code in an email
    /// or SMS
    /// message.
    ///
    /// Local users who signed up in your user pool are the only type of user who
    /// can confirm
    /// sign-up with a code. Users who federate through an external identity
    /// provider (IdP) have
    /// already been confirmed by their IdP.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn confirmSignUp(self: *Self, allocator: std.mem.Allocator, input: confirm_sign_up.ConfirmSignUpInput, options: CallOptions) !confirm_sign_up.ConfirmSignUpOutput {
        return confirm_sign_up.execute(self, allocator, input, options);
    }

    /// Creates a new group in the specified user pool. For more information about
    /// user pool
    /// groups, see [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: CallOptions) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Adds a configuration and trust relationship between a third-party identity
    /// provider
    /// (IdP) and a user pool. Amazon Cognito accepts sign-in with third-party
    /// identity providers through
    /// managed login and OIDC relying-party libraries. For more information, see
    /// [Third-party IdP
    /// sign-in](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: create_identity_provider.CreateIdentityProviderInput, options: CallOptions) !create_identity_provider.CreateIdentityProviderOutput {
        return create_identity_provider.execute(self, allocator, input, options);
    }

    /// Creates a new set of branding settings for a user pool style and associates
    /// it with an
    /// app client. This operation is the programmatic option for the creation of a
    /// new style in
    /// the branding editor.
    ///
    /// Provides values for UI customization in a `Settings` JSON object and image
    /// files in an `Assets` array. To send the JSON object `Document`
    /// type parameter in `Settings`, you might need to update to the most recent
    /// version of your Amazon Web Services SDK. To create a new style with default
    /// settings, set
    /// `UseCognitoProvidedValues` to `true` and don't provide
    /// values for any other options.
    ///
    /// This operation has a 2-megabyte request-size limit and include the CSS
    /// settings and
    /// image assets for your app client. Your branding settings might exceed 2MB in
    /// size. Amazon Cognito
    /// doesn't require that you pass all parameters in one request and preserves
    /// existing
    /// style settings that you don't specify. If your request is larger than 2MB,
    /// separate it
    /// into multiple requests, each with a size smaller than the limit.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createManagedLoginBranding(self: *Self, allocator: std.mem.Allocator, input: create_managed_login_branding.CreateManagedLoginBrandingInput, options: CallOptions) !create_managed_login_branding.CreateManagedLoginBrandingOutput {
        return create_managed_login_branding.execute(self, allocator, input, options);
    }

    /// Creates a new OAuth2.0 resource server and defines custom scopes within it.
    /// Resource
    /// servers are associated with custom scopes and machine-to-machine (M2M)
    /// authorization.
    /// For more information, see [Access control with resource
    /// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createResourceServer(self: *Self, allocator: std.mem.Allocator, input: create_resource_server.CreateResourceServerInput, options: CallOptions) !create_resource_server.CreateResourceServerOutput {
        return create_resource_server.execute(self, allocator, input, options);
    }

    /// Creates terms documents for the requested app client. When Terms and
    /// conditions and
    /// Privacy policy documents are configured, the app client displays links to
    /// them in the
    /// sign-up page of managed login for the app client.
    ///
    /// You can provide URLs for terms documents in the languages that are supported
    /// by [managed login
    /// localization](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-localization). Amazon Cognito directs users to the terms documents for
    /// their current language, with fallback to `default` if no document exists for
    /// the language.
    ///
    /// Each request accepts one type of terms document and a map of
    /// language-to-link for that
    /// document type. You must provide both types of terms documents in at least
    /// one language
    /// before Amazon Cognito displays your terms documents. Supply each type in
    /// separate
    /// requests.
    ///
    /// For more information, see [Terms
    /// documents](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-terms-documents).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createTerms(self: *Self, allocator: std.mem.Allocator, input: create_terms.CreateTermsInput, options: CallOptions) !create_terms.CreateTermsOutput {
        return create_terms.execute(self, allocator, input, options);
    }

    /// Creates a user import job. You can import users into user pools from a
    /// comma-separated
    /// values (CSV) file without adding Amazon Cognito MAU costs to your Amazon Web
    /// Services bill.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createUserImportJob(self: *Self, allocator: std.mem.Allocator, input: create_user_import_job.CreateUserImportJobInput, options: CallOptions) !create_user_import_job.CreateUserImportJobOutput {
        return create_user_import_job.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Cognito user pool. This operation sets basic and
    /// advanced configuration
    /// options.
    ///
    /// If you don't provide a value for an attribute, Amazon Cognito sets it to its
    /// default value.
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createUserPool(self: *Self, allocator: std.mem.Allocator, input: create_user_pool.CreateUserPoolInput, options: CallOptions) !create_user_pool.CreateUserPoolOutput {
        return create_user_pool.execute(self, allocator, input, options);
    }

    /// Creates an app client in a user pool. This operation sets basic and advanced
    /// configuration options.
    ///
    /// Unlike app clients created in the console, Amazon Cognito doesn't
    /// automatically assign a
    /// branding style to app clients that you configure with this API operation.
    /// Managed login and classic hosted UI pages aren't
    /// available for your client until after you apply a branding style.
    ///
    /// If you don't provide a value for an attribute, Amazon Cognito sets it to its
    /// default value.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createUserPoolClient(self: *Self, allocator: std.mem.Allocator, input: create_user_pool_client.CreateUserPoolClientInput, options: CallOptions) !create_user_pool_client.CreateUserPoolClientOutput {
        return create_user_pool_client.execute(self, allocator, input, options);
    }

    /// A user pool domain hosts managed login, an authorization server and web
    /// server for
    /// authentication in your application. This operation creates a new user pool
    /// prefix domain
    /// or custom domain and sets the managed login branding version. Set the
    /// branding version
    /// to `1` for hosted UI (classic) or `2` for managed login. When you
    /// choose a custom domain, you must provide an SSL certificate in the US East
    /// (N. Virginia)
    /// Amazon Web Services Region in your request.
    ///
    /// Your prefix domain might take up to one minute to take effect. Your custom
    /// domain is
    /// online within five minutes, but it can take up to one hour to distribute
    /// your SSL
    /// certificate.
    ///
    /// For more information about adding a custom domain to your user pool, see
    /// [Configuring a user pool
    /// domain](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn createUserPoolDomain(self: *Self, allocator: std.mem.Allocator, input: create_user_pool_domain.CreateUserPoolDomainInput, options: CallOptions) !create_user_pool_domain.CreateUserPoolDomainOutput {
        return create_user_pool_domain.execute(self, allocator, input, options);
    }

    /// Deletes a group from the specified user pool. When you delete a group, that
    /// group no
    /// longer contributes to users' `cognito:preferred_group` or
    /// `cognito:groups` claims, and no longer influence access-control decision
    /// that are based on group membership. For more information about user pool
    /// groups, see
    /// [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: CallOptions) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes a user pool identity provider (IdP). After you delete an IdP, users
    /// can no
    /// longer sign in to your user pool through that IdP. For more information
    /// about user pool
    /// IdPs, see [Third-party IdP
    /// sign-in](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn deleteIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: delete_identity_provider.DeleteIdentityProviderInput, options: CallOptions) !delete_identity_provider.DeleteIdentityProviderOutput {
        return delete_identity_provider.execute(self, allocator, input, options);
    }

    /// Deletes a managed login branding style. When you delete a style, you delete
    /// the
    /// branding association for an app client. When an app client doesn't have a
    /// style
    /// assigned, your managed login pages for that app client are nonfunctional
    /// until you
    /// create a new style or switch the domain branding version.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn deleteManagedLoginBranding(self: *Self, allocator: std.mem.Allocator, input: delete_managed_login_branding.DeleteManagedLoginBrandingInput, options: CallOptions) !delete_managed_login_branding.DeleteManagedLoginBrandingOutput {
        return delete_managed_login_branding.execute(self, allocator, input, options);
    }

    /// Deletes a resource server. After you delete a resource server, users can no
    /// longer
    /// generate access tokens with scopes that are associate with that resource
    /// server.
    ///
    /// Resource servers are associated with custom scopes and machine-to-machine
    /// (M2M)
    /// authorization. For more information, see [Access control with resource
    /// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn deleteResourceServer(self: *Self, allocator: std.mem.Allocator, input: delete_resource_server.DeleteResourceServerInput, options: CallOptions) !delete_resource_server.DeleteResourceServerOutput {
        return delete_resource_server.execute(self, allocator, input, options);
    }

    /// Deletes the terms documents with the requested ID from your app client.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn deleteTerms(self: *Self, allocator: std.mem.Allocator, input: delete_terms.DeleteTermsInput, options: CallOptions) !delete_terms.DeleteTermsOutput {
        return delete_terms.execute(self, allocator, input, options);
    }

    /// Deletes the profile of the currently signed-in user. A deleted user profile
    /// can no
    /// longer be used to sign in and can't be restored.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes attributes from the currently signed-in user. For example, your
    /// application
    /// can submit a request to this operation when a user wants to remove their
    /// `birthdate` attribute value.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn deleteUserAttributes(self: *Self, allocator: std.mem.Allocator, input: delete_user_attributes.DeleteUserAttributesInput, options: CallOptions) !delete_user_attributes.DeleteUserAttributesOutput {
        return delete_user_attributes.execute(self, allocator, input, options);
    }

    /// Deletes a user pool. After you delete a user pool, users can no longer sign
    /// in to any
    /// associated applications.
    ///
    /// When you delete a user pool, it's no longer visible or operational in your
    /// Amazon Web Services account. Amazon Cognito retains deleted user pools in an
    /// inactive state for 14
    /// days, then begins a cleanup process that fully removes them from Amazon Web
    /// Services systems. In case
    /// of accidental deletion, contact Amazon Web Services Support within 14 days
    /// for restoration
    /// assistance.
    ///
    /// Amazon Cognito begins full deletion of all resources from deleted user pools
    /// after 14 days. In
    /// the case of large user pools, the cleanup process might take significant
    /// additional time
    /// before all user data is permanently deleted.
    pub fn deleteUserPool(self: *Self, allocator: std.mem.Allocator, input: delete_user_pool.DeleteUserPoolInput, options: CallOptions) !delete_user_pool.DeleteUserPoolOutput {
        return delete_user_pool.execute(self, allocator, input, options);
    }

    /// Deletes a user pool app client. After you delete an app client, users can no
    /// longer
    /// sign in to the associated application.
    pub fn deleteUserPoolClient(self: *Self, allocator: std.mem.Allocator, input: delete_user_pool_client.DeleteUserPoolClientInput, options: CallOptions) !delete_user_pool_client.DeleteUserPoolClientOutput {
        return delete_user_pool_client.execute(self, allocator, input, options);
    }

    /// Given a user pool ID and domain identifier, deletes a user pool domain.
    /// After you
    /// delete a user pool domain, your managed login pages and authorization server
    /// are no
    /// longer available.
    pub fn deleteUserPoolDomain(self: *Self, allocator: std.mem.Allocator, input: delete_user_pool_domain.DeleteUserPoolDomainInput, options: CallOptions) !delete_user_pool_domain.DeleteUserPoolDomainOutput {
        return delete_user_pool_domain.execute(self, allocator, input, options);
    }

    /// Deletes a registered passkey, or WebAuthn, authenticator for the currently
    /// signed-in
    /// user.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn deleteWebAuthnCredential(self: *Self, allocator: std.mem.Allocator, input: delete_web_authn_credential.DeleteWebAuthnCredentialInput, options: CallOptions) !delete_web_authn_credential.DeleteWebAuthnCredentialOutput {
        return delete_web_authn_credential.execute(self, allocator, input, options);
    }

    /// Given a user pool ID and identity provider (IdP) name, returns details about
    /// the
    /// IdP.
    pub fn describeIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: describe_identity_provider.DescribeIdentityProviderInput, options: CallOptions) !describe_identity_provider.DescribeIdentityProviderOutput {
        return describe_identity_provider.execute(self, allocator, input, options);
    }

    /// Given the ID of a managed login branding style, returns detailed information
    /// about the
    /// style.
    pub fn describeManagedLoginBranding(self: *Self, allocator: std.mem.Allocator, input: describe_managed_login_branding.DescribeManagedLoginBrandingInput, options: CallOptions) !describe_managed_login_branding.DescribeManagedLoginBrandingOutput {
        return describe_managed_login_branding.execute(self, allocator, input, options);
    }

    /// Given the ID of a user pool app client, returns detailed information about
    /// the style
    /// assigned to the app client.
    pub fn describeManagedLoginBrandingByClient(self: *Self, allocator: std.mem.Allocator, input: describe_managed_login_branding_by_client.DescribeManagedLoginBrandingByClientInput, options: CallOptions) !describe_managed_login_branding_by_client.DescribeManagedLoginBrandingByClientOutput {
        return describe_managed_login_branding_by_client.execute(self, allocator, input, options);
    }

    /// Describes a resource server. For more information about resource servers,
    /// see [Access control with resource
    /// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
    pub fn describeResourceServer(self: *Self, allocator: std.mem.Allocator, input: describe_resource_server.DescribeResourceServerInput, options: CallOptions) !describe_resource_server.DescribeResourceServerOutput {
        return describe_resource_server.execute(self, allocator, input, options);
    }

    /// Given an app client or user pool ID where threat protection is configured,
    /// describes
    /// the risk configuration. This operation returns details about adaptive
    /// authentication,
    /// compromised credentials, and IP-address allow- and denylists. For more
    /// information about
    /// threat protection, see [Threat
    /// protection](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-threat-protection.html).
    pub fn describeRiskConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_risk_configuration.DescribeRiskConfigurationInput, options: CallOptions) !describe_risk_configuration.DescribeRiskConfigurationOutput {
        return describe_risk_configuration.execute(self, allocator, input, options);
    }

    /// Returns details for the requested terms documents ID. For more information,
    /// see [Terms
    /// documents](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-terms-documents).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn describeTerms(self: *Self, allocator: std.mem.Allocator, input: describe_terms.DescribeTermsInput, options: CallOptions) !describe_terms.DescribeTermsOutput {
        return describe_terms.execute(self, allocator, input, options);
    }

    /// Describes a user import job. For more information about user CSV import, see
    /// [Importing users from a CSV
    /// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
    pub fn describeUserImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_user_import_job.DescribeUserImportJobInput, options: CallOptions) !describe_user_import_job.DescribeUserImportJobOutput {
        return describe_user_import_job.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns configuration information. This operation is
    /// useful when
    /// you want to inspect an existing user pool and programmatically replicate the
    /// configuration to another user pool.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn describeUserPool(self: *Self, allocator: std.mem.Allocator, input: describe_user_pool.DescribeUserPoolInput, options: CallOptions) !describe_user_pool.DescribeUserPoolOutput {
        return describe_user_pool.execute(self, allocator, input, options);
    }

    /// Given an app client ID, returns configuration information. This operation is
    /// useful
    /// when you want to inspect an existing app client and programmatically
    /// replicate the
    /// configuration to another app client. For more information about app clients,
    /// see [App
    /// clients](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn describeUserPoolClient(self: *Self, allocator: std.mem.Allocator, input: describe_user_pool_client.DescribeUserPoolClientInput, options: CallOptions) !describe_user_pool_client.DescribeUserPoolClientOutput {
        return describe_user_pool_client.execute(self, allocator, input, options);
    }

    /// Given a user pool domain name, returns information about the domain
    /// configuration.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn describeUserPoolDomain(self: *Self, allocator: std.mem.Allocator, input: describe_user_pool_domain.DescribeUserPoolDomainInput, options: CallOptions) !describe_user_pool_domain.DescribeUserPoolDomainOutput {
        return describe_user_pool_domain.execute(self, allocator, input, options);
    }

    /// Given a device key, deletes a remembered device as the currently signed-in
    /// user. For
    /// more information about device authentication, see [Working with user devices
    /// in your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn forgetDevice(self: *Self, allocator: std.mem.Allocator, input: forget_device.ForgetDeviceInput, options: CallOptions) !forget_device.ForgetDeviceOutput {
        return forget_device.execute(self, allocator, input, options);
    }

    /// Sends a password-reset confirmation code to the email address or phone
    /// number of the
    /// requested username. The message delivery method is determined by the user's
    /// available attributes and the `AccountRecoverySetting` configuration of the
    /// user pool.
    ///
    /// For the `Username` parameter, you can use the username or an email, phone,
    /// or preferred username alias.
    ///
    /// If neither a verified phone number nor a verified email exists, Amazon
    /// Cognito responds with an
    /// `InvalidParameterException` error . If your app client has a client
    /// secret and you don't provide a `SECRET_HASH` parameter, this API returns
    /// `NotAuthorizedException`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn forgotPassword(self: *Self, allocator: std.mem.Allocator, input: forgot_password.ForgotPasswordInput, options: CallOptions) !forgot_password.ForgotPasswordOutput {
        return forgot_password.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, generates a comma-separated value (CSV) list populated
    /// with
    /// available user attributes in the user pool. This list is the header for the
    /// CSV file
    /// that determines the users in a user import job. Save the content of
    /// `CSVHeader` in the response as a `.csv` file and populate it
    /// with the usernames and attributes of users that you want to import. For more
    /// information
    /// about CSV user import, see [Importing users from a CSV
    /// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn getCsvHeader(self: *Self, allocator: std.mem.Allocator, input: get_csv_header.GetCSVHeaderInput, options: CallOptions) !get_csv_header.GetCSVHeaderOutput {
        return get_csv_header.execute(self, allocator, input, options);
    }

    /// Given a device key, returns information about a remembered device for the
    /// current
    /// user. For more information about device authentication, see [Working with
    /// user devices in your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn getDevice(self: *Self, allocator: std.mem.Allocator, input: get_device.GetDeviceInput, options: CallOptions) !get_device.GetDeviceOutput {
        return get_device.execute(self, allocator, input, options);
    }

    /// Given a user pool ID and a group name, returns information about the user
    /// group.
    ///
    /// For more information about user pool groups, see [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: CallOptions) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Given the identifier of an identity provider (IdP), for example
    /// `examplecorp`, returns information about the user pool configuration for
    /// that IdP. For more information about IdPs, see [Third-party IdP
    /// sign-in](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html).
    pub fn getIdentityProviderByIdentifier(self: *Self, allocator: std.mem.Allocator, input: get_identity_provider_by_identifier.GetIdentityProviderByIdentifierInput, options: CallOptions) !get_identity_provider_by_identifier.GetIdentityProviderByIdentifierOutput {
        return get_identity_provider_by_identifier.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns the logging configuration. User pools can
    /// export
    /// message-delivery error and threat-protection activity logs to external
    /// Amazon Web Services services. For more information, see [Exporting user pool
    /// logs](https://docs.aws.amazon.com/cognito/latest/developerguide/exporting-quotas-and-usage.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn getLogDeliveryConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_log_delivery_configuration.GetLogDeliveryConfigurationInput, options: CallOptions) !get_log_delivery_configuration.GetLogDeliveryConfigurationOutput {
        return get_log_delivery_configuration.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns the signing certificate for SAML 2.0
    /// federation.
    ///
    /// Issued certificates are valid for 10 years from the date of issue. Amazon
    /// Cognito issues and
    /// assigns a new signing certificate annually. This renewal process returns a
    /// new value in
    /// the response to `GetSigningCertificate`, but doesn't invalidate the original
    /// certificate.
    ///
    /// For more information, see [Signing SAML
    /// requests](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-SAML-signing-encryption.html#cognito-user-pools-SAML-signing).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn getSigningCertificate(self: *Self, allocator: std.mem.Allocator, input: get_signing_certificate.GetSigningCertificateInput, options: CallOptions) !get_signing_certificate.GetSigningCertificateOutput {
        return get_signing_certificate.execute(self, allocator, input, options);
    }

    /// Given a refresh token, issues new ID, access, and optionally refresh tokens
    /// for the
    /// user who owns the submitted token. This operation issues a new refresh token
    /// and
    /// invalidates the original refresh token after an optional grace period when
    /// refresh token
    /// rotation is enabled. If refresh token rotation is disabled, issues new ID
    /// and access
    /// tokens only.
    pub fn getTokensFromRefreshToken(self: *Self, allocator: std.mem.Allocator, input: get_tokens_from_refresh_token.GetTokensFromRefreshTokenInput, options: CallOptions) !get_tokens_from_refresh_token.GetTokensFromRefreshTokenOutput {
        return get_tokens_from_refresh_token.execute(self, allocator, input, options);
    }

    /// Given a user pool ID or app client, returns information about classic hosted
    /// UI
    /// branding that you applied, if any. Returns user-pool level branding
    /// information if no
    /// app client branding is applied, or if you don't specify an app client ID.
    /// Returns
    /// an empty object if you haven't applied hosted UI branding to either the
    /// client or
    /// the user pool. For more information, see [Hosted UI (classic)
    /// branding](https://docs.aws.amazon.com/cognito/latest/developerguide/hosted-ui-classic-branding.html).
    pub fn getUiCustomization(self: *Self, allocator: std.mem.Allocator, input: get_ui_customization.GetUICustomizationInput, options: CallOptions) !get_ui_customization.GetUICustomizationOutput {
        return get_ui_customization.execute(self, allocator, input, options);
    }

    /// Gets user attributes and and MFA settings for the currently signed-in user.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: CallOptions) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// Given an attribute name, sends a user attribute verification code for the
    /// specified
    /// attribute name to the currently signed-in user.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn getUserAttributeVerificationCode(self: *Self, allocator: std.mem.Allocator, input: get_user_attribute_verification_code.GetUserAttributeVerificationCodeInput, options: CallOptions) !get_user_attribute_verification_code.GetUserAttributeVerificationCodeOutput {
        return get_user_attribute_verification_code.execute(self, allocator, input, options);
    }

    /// Lists the authentication options for the currently signed-in user. Returns
    /// the
    /// following:
    ///
    /// * The user's multi-factor authentication (MFA) preferences.
    ///
    /// * The user's options for choice-based authentication with the
    /// `USER_AUTH` flow.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn getUserAuthFactors(self: *Self, allocator: std.mem.Allocator, input: get_user_auth_factors.GetUserAuthFactorsInput, options: CallOptions) !get_user_auth_factors.GetUserAuthFactorsOutput {
        return get_user_auth_factors.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns configuration for sign-in with WebAuthn
    /// authenticators
    /// and for multi-factor authentication (MFA). This operation describes the
    /// following:
    ///
    /// * The WebAuthn relying party (RP) ID and user-verification settings.
    ///
    /// * The required, optional, or disabled state of MFA for all user pool
    /// users.
    ///
    /// * The message templates for email and SMS MFA.
    ///
    /// * The enabled or disabled state of time-based one-time password (TOTP)
    /// MFA.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn getUserPoolMfaConfig(self: *Self, allocator: std.mem.Allocator, input: get_user_pool_mfa_config.GetUserPoolMfaConfigInput, options: CallOptions) !get_user_pool_mfa_config.GetUserPoolMfaConfigOutput {
        return get_user_pool_mfa_config.execute(self, allocator, input, options);
    }

    /// Invalidates the identity, access, and refresh tokens that Amazon Cognito
    /// issued to a user. Call
    /// this operation when your user signs out of your app. This results in the
    /// following
    /// behavior.
    ///
    /// * Amazon Cognito no longer accepts *token-authorized* user operations
    /// that you authorize with a signed-out user's access tokens. For more
    /// information,
    /// see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// Amazon Cognito returns an `Access Token has been revoked` error when your
    /// app attempts to authorize a user pools API request with a revoked access
    /// token
    /// that contains the scope `aws.cognito.signin.user.admin`.
    ///
    /// * Amazon Cognito no longer accepts a signed-out user's ID token in a [GetId
    ///   ](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetId.html) request to an identity pool with
    /// `ServerSideTokenCheck` enabled for its user pool IdP
    /// configuration in
    /// [CognitoIdentityProvider](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_CognitoIdentityProvider.html).
    ///
    /// * Amazon Cognito no longer accepts a signed-out user's refresh tokens in
    ///   refresh
    /// requests.
    ///
    /// Other requests might be valid until your user's token expires. This
    /// operation
    /// doesn't clear the [managed
    /// login](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html) session cookie. To clear the session for
    /// a user who signed in with managed login or the classic hosted UI, direct
    /// their browser
    /// session to the [logout
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/logout-endpoint.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn globalSignOut(self: *Self, allocator: std.mem.Allocator, input: global_sign_out.GlobalSignOutInput, options: CallOptions) !global_sign_out.GlobalSignOutOutput {
        return global_sign_out.execute(self, allocator, input, options);
    }

    /// Declares an authentication flow and initiates sign-in for a user in the
    /// Amazon Cognito user
    /// directory. Amazon Cognito might respond with an additional challenge or an
    /// `AuthenticationResult` that contains the outcome of a successful
    /// authentication. You can't sign in a user with a federated IdP with
    /// `InitiateAuth`. For more information, see
    /// [Authentication](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication.html).
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn initiateAuth(self: *Self, allocator: std.mem.Allocator, input: initiate_auth.InitiateAuthInput, options: CallOptions) !initiate_auth.InitiateAuthOutput {
        return initiate_auth.execute(self, allocator, input, options);
    }

    /// Lists the devices that Amazon Cognito has registered to the currently
    /// signed-in user. For more
    /// information about device authentication, see [Working with user devices in
    /// your user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: CallOptions) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns user pool groups and their details.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: CallOptions) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns information about configured identity
    /// providers (IdPs).
    /// For more information about IdPs, see [Third-party IdP
    /// sign-in](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listIdentityProviders(self: *Self, allocator: std.mem.Allocator, input: list_identity_providers.ListIdentityProvidersInput, options: CallOptions) !list_identity_providers.ListIdentityProvidersOutput {
        return list_identity_providers.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns all resource servers and their details. For
    /// more
    /// information about resource servers, see [Access control with resource
    /// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listResourceServers(self: *Self, allocator: std.mem.Allocator, input: list_resource_servers.ListResourceServersInput, options: CallOptions) !list_resource_servers.ListResourceServersOutput {
        return list_resource_servers.execute(self, allocator, input, options);
    }

    /// Lists the tags that are assigned to an Amazon Cognito user pool. For more
    /// information, see
    /// [Tagging
    /// resources](https://docs.aws.amazon.com/cognito/latest/developerguide/tagging.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns details about all terms documents for the requested user pool.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listTerms(self: *Self, allocator: std.mem.Allocator, input: list_terms.ListTermsInput, options: CallOptions) !list_terms.ListTermsOutput {
        return list_terms.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns user import jobs and their details. Import
    /// jobs are
    /// retained in user pool configuration so that you can stage, stop, start,
    /// review, and
    /// delete them. For more information about user import, see [Importing users
    /// from a CSV
    /// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listUserImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_user_import_jobs.ListUserImportJobsInput, options: CallOptions) !list_user_import_jobs.ListUserImportJobsOutput {
        return list_user_import_jobs.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, lists app clients. App clients are sets of rules for
    /// the access
    /// that you want a user pool to grant to one application. For more information,
    /// see [App
    /// clients](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-client-apps.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listUserPoolClients(self: *Self, allocator: std.mem.Allocator, input: list_user_pool_clients.ListUserPoolClientsInput, options: CallOptions) !list_user_pool_clients.ListUserPoolClientsOutput {
        return list_user_pool_clients.execute(self, allocator, input, options);
    }

    /// Lists user pools and their details in the current Amazon Web Services
    /// account.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listUserPools(self: *Self, allocator: std.mem.Allocator, input: list_user_pools.ListUserPoolsInput, options: CallOptions) !list_user_pools.ListUserPoolsOutput {
        return list_user_pools.execute(self, allocator, input, options);
    }

    /// Given a user pool ID, returns a list of users and their basic details in a
    /// user
    /// pool.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: CallOptions) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Given a user pool ID and a group name, returns a list of users in the group.
    /// For more
    /// information about user pool groups, see [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn listUsersInGroup(self: *Self, allocator: std.mem.Allocator, input: list_users_in_group.ListUsersInGroupInput, options: CallOptions) !list_users_in_group.ListUsersInGroupOutput {
        return list_users_in_group.execute(self, allocator, input, options);
    }

    /// Generates a list of the currently signed-in user's registered passkey, or
    /// WebAuthn, credentials.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn listWebAuthnCredentials(self: *Self, allocator: std.mem.Allocator, input: list_web_authn_credentials.ListWebAuthnCredentialsInput, options: CallOptions) !list_web_authn_credentials.ListWebAuthnCredentialsOutput {
        return list_web_authn_credentials.execute(self, allocator, input, options);
    }

    /// Resends the code that confirms a new account for a user who has signed up in
    /// your user
    /// pool. Amazon Cognito sends confirmation codes to the user attribute in the
    /// `AutoVerifiedAttributes` property of your user pool. When you prompt new
    /// users for the confirmation code, include a "Resend code" option that
    /// generates a call to
    /// this API operation.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn resendConfirmationCode(self: *Self, allocator: std.mem.Allocator, input: resend_confirmation_code.ResendConfirmationCodeInput, options: CallOptions) !resend_confirmation_code.ResendConfirmationCodeOutput {
        return resend_confirmation_code.execute(self, allocator, input, options);
    }

    /// Some API operations in a user pool generate a challenge, like a prompt for
    /// an MFA
    /// code, for device authentication that bypasses MFA, or for a custom
    /// authentication
    /// challenge. A `RespondToAuthChallenge` API request provides the answer to
    /// that
    /// challenge, like a code or a secure remote password (SRP). The parameters of
    /// a response
    /// to an authentication challenge vary with the type of challenge.
    ///
    /// For more information about custom authentication challenges, see [Custom
    /// authentication challenge Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn respondToAuthChallenge(self: *Self, allocator: std.mem.Allocator, input: respond_to_auth_challenge.RespondToAuthChallengeInput, options: CallOptions) !respond_to_auth_challenge.RespondToAuthChallengeOutput {
        return respond_to_auth_challenge.execute(self, allocator, input, options);
    }

    /// Revokes all of the access tokens generated by, and at the same time as, the
    /// specified
    /// refresh token. After a token is revoked, you can't use the revoked token to
    /// access Amazon Cognito
    /// user APIs, or to authorize access to your resource server.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn revokeToken(self: *Self, allocator: std.mem.Allocator, input: revoke_token.RevokeTokenInput, options: CallOptions) !revoke_token.RevokeTokenOutput {
        return revoke_token.execute(self, allocator, input, options);
    }

    /// Sets up or modifies the logging configuration of a user pool. User pools can
    /// export
    /// user notification logs and, when threat protection is active, user-activity
    /// logs. For
    /// more information, see [Exporting user
    /// pool
    /// logs](https://docs.aws.amazon.com/cognito/latest/developerguide/exporting-quotas-and-usage.html).
    pub fn setLogDeliveryConfiguration(self: *Self, allocator: std.mem.Allocator, input: set_log_delivery_configuration.SetLogDeliveryConfigurationInput, options: CallOptions) !set_log_delivery_configuration.SetLogDeliveryConfigurationOutput {
        return set_log_delivery_configuration.execute(self, allocator, input, options);
    }

    /// Configures threat protection for a user pool or app client. Sets
    /// configuration for the
    /// following.
    ///
    /// * Responses to risks with adaptive authentication
    ///
    /// * Responses to vulnerable passwords with compromised-credentials
    /// detection
    ///
    /// * Notifications to users who have had risky activity detected
    ///
    /// * IP-address denylist and allowlist
    ///
    /// To set the risk configuration for the user pool to defaults, send this
    /// request with
    /// only the `UserPoolId` parameter. To reset the threat protection settings of
    /// an app client to be inherited from the user pool, send `UserPoolId` and
    /// `ClientId` parameters only. To change threat protection to audit-only or
    /// off, update the value of `UserPoolAddOns` in an `UpdateUserPool`
    /// request. To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    pub fn setRiskConfiguration(self: *Self, allocator: std.mem.Allocator, input: set_risk_configuration.SetRiskConfigurationInput, options: CallOptions) !set_risk_configuration.SetRiskConfigurationOutput {
        return set_risk_configuration.execute(self, allocator, input, options);
    }

    /// Configures UI branding settings for domains with the hosted UI (classic)
    /// branding
    /// version. Your user pool must have a domain. Configure a domain with .
    ///
    /// Set the default configuration for all clients with a `ClientId` of
    /// `ALL`. When the `ClientId` value is an app client ID, the
    /// settings you pass in this request apply to that app client and override the
    /// default
    /// `ALL` configuration.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn setUiCustomization(self: *Self, allocator: std.mem.Allocator, input: set_ui_customization.SetUICustomizationInput, options: CallOptions) !set_ui_customization.SetUICustomizationOutput {
        return set_ui_customization.execute(self, allocator, input, options);
    }

    /// Set the user's multi-factor authentication (MFA) method preference,
    /// including which
    /// MFA factors are activated and if any are preferred. Only one factor can be
    /// set as
    /// preferred. The preferred MFA factor will be used to authenticate a user if
    /// multiple
    /// factors are activated. If multiple options are activated and no preference
    /// is set, a
    /// challenge to choose an MFA option will be returned during sign-in. If an MFA
    /// type is
    /// activated for a user, the user will be prompted for MFA during all sign-in
    /// attempts
    /// unless device tracking is turned on and the device has been trusted. If you
    /// want MFA to
    /// be applied selectively based on the assessed risk level of sign-in attempts,
    /// deactivate
    /// MFA for users and turn on Adaptive Authentication for the user pool.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn setUserMfaPreference(self: *Self, allocator: std.mem.Allocator, input: set_user_mfa_preference.SetUserMFAPreferenceInput, options: CallOptions) !set_user_mfa_preference.SetUserMFAPreferenceOutput {
        return set_user_mfa_preference.execute(self, allocator, input, options);
    }

    /// Sets user pool multi-factor authentication (MFA) and passkey configuration.
    /// For more
    /// information about user pool MFA, see [Adding
    /// MFA](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-mfa.html). For more information about WebAuthn passkeys see [Authentication flows](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow-methods.html#amazon-cognito-user-pools-authentication-flow-methods-passkey).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn setUserPoolMfaConfig(self: *Self, allocator: std.mem.Allocator, input: set_user_pool_mfa_config.SetUserPoolMfaConfigInput, options: CallOptions) !set_user_pool_mfa_config.SetUserPoolMfaConfigOutput {
        return set_user_pool_mfa_config.execute(self, allocator, input, options);
    }

    /// *This action is no longer supported.* You can use it to configure
    /// only SMS MFA. You can't use it to configure time-based one-time password
    /// (TOTP) software
    /// token or email MFA.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn setUserSettings(self: *Self, allocator: std.mem.Allocator, input: set_user_settings.SetUserSettingsInput, options: CallOptions) !set_user_settings.SetUserSettingsOutput {
        return set_user_settings.execute(self, allocator, input, options);
    }

    /// Registers a user with an app client and requests a user name, password, and
    /// user
    /// attributes in the user pool.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// You might receive a `LimitExceeded` exception in response to this request
    /// if you have exceeded a rate quota for email or SMS messages, and if your
    /// user pool
    /// automatically verifies email addresses or phone numbers. When you get this
    /// exception in
    /// the response, the user is successfully created and is in an `UNCONFIRMED`
    /// state.
    pub fn signUp(self: *Self, allocator: std.mem.Allocator, input: sign_up.SignUpInput, options: CallOptions) !sign_up.SignUpOutput {
        return sign_up.execute(self, allocator, input, options);
    }

    /// Instructs your user pool to start importing users from a CSV file that
    /// contains their
    /// usernames and attributes. For more information about importing users from a
    /// CSV file,
    /// see [Importing users from a CSV
    /// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
    pub fn startUserImportJob(self: *Self, allocator: std.mem.Allocator, input: start_user_import_job.StartUserImportJobInput, options: CallOptions) !start_user_import_job.StartUserImportJobOutput {
        return start_user_import_job.execute(self, allocator, input, options);
    }

    /// Requests credential creation options from your user pool for the currently
    /// signed-in
    /// user. Returns information about the user pool, the user profile, and
    /// authentication
    /// requirements. Users must provide this information in their request to enroll
    /// your
    /// application with their passkey provider.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    pub fn startWebAuthnRegistration(self: *Self, allocator: std.mem.Allocator, input: start_web_authn_registration.StartWebAuthnRegistrationInput, options: CallOptions) !start_web_authn_registration.StartWebAuthnRegistrationOutput {
        return start_web_authn_registration.execute(self, allocator, input, options);
    }

    /// Instructs your user pool to stop a running job that's importing users from a
    /// CSV
    /// file that contains their usernames and attributes. For more information
    /// about importing
    /// users from a CSV file, see [Importing users from a CSV
    /// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
    pub fn stopUserImportJob(self: *Self, allocator: std.mem.Allocator, input: stop_user_import_job.StopUserImportJobInput, options: CallOptions) !stop_user_import_job.StopUserImportJobOutput {
        return stop_user_import_job.execute(self, allocator, input, options);
    }

    /// Assigns a set of tags to an Amazon Cognito user pool. A tag is a label that
    /// you can use to
    /// categorize and manage user pools in different ways, such as by purpose,
    /// owner,
    /// environment, or other criteria.
    ///
    /// Each tag consists of a key and value, both of which you define. A key is a
    /// general
    /// category for more specific values. For example, if you have two versions of
    /// a user pool,
    /// one for testing and another for production, you might assign an
    /// `Environment`
    /// tag key to both user pools. The value of this key might be `Test` for one
    /// user pool, and `Production` for the other.
    ///
    /// Tags are useful for cost tracking and access control. You can activate your
    /// tags so
    /// that they appear on the Billing and Cost Management console, where you can
    /// track the
    /// costs associated with your user pools. In an Identity and Access Management
    /// policy, you can constrain
    /// permissions for user pools based on specific tags or tag values.
    ///
    /// You can use this action up to 5 times per second, per account. A user pool
    /// can have as
    /// many as 50 tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Given tag IDs that you previously assigned to a user pool, removes them.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Provides the feedback for an authentication event generated by threat
    /// protection
    /// features. The user's response indicates that you think that the event either
    /// was from a
    /// valid user or was an unwanted authentication attempt. This feedback improves
    /// the risk
    /// evaluation decision for the user pool as part of Amazon Cognito threat
    /// protection.
    /// To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    ///
    /// This operation requires a `FeedbackToken` that Amazon Cognito generates and
    /// adds to
    /// notification emails when users have potentially suspicious authentication
    /// events. Users
    /// invoke this operation when they select the link that corresponds to
    /// `{one-click-link-valid}` or `{one-click-link-invalid}` in your
    /// notification template. Because `FeedbackToken` is a required parameter, you
    /// can't make requests to `UpdateAuthEventFeedback` without the contents of
    /// the notification email message.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn updateAuthEventFeedback(self: *Self, allocator: std.mem.Allocator, input: update_auth_event_feedback.UpdateAuthEventFeedbackInput, options: CallOptions) !update_auth_event_feedback.UpdateAuthEventFeedbackOutput {
        return update_auth_event_feedback.execute(self, allocator, input, options);
    }

    /// Updates the status of a the currently signed-in user's device so that it is
    /// marked as remembered or not remembered for the purpose of device
    /// authentication. Device
    /// authentication is a "remember me" mechanism that silently completes sign-in
    /// from trusted
    /// devices with a device key instead of a user-provided MFA code. This
    /// operation changes
    /// the status of a device without deleting it, so you can enable it again
    /// later. For more
    /// information about device authentication, see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn updateDeviceStatus(self: *Self, allocator: std.mem.Allocator, input: update_device_status.UpdateDeviceStatusInput, options: CallOptions) !update_device_status.UpdateDeviceStatusOutput {
        return update_device_status.execute(self, allocator, input, options);
    }

    /// Given the name of a user pool group, updates any of the properties for
    /// precedence,
    /// IAM role, or description. For more information about user pool groups, see
    /// [Adding groups to a user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: CallOptions) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Modifies the configuration and trust relationship between a third-party
    /// identity
    /// provider (IdP) and a user pool. Amazon Cognito accepts sign-in with
    /// third-party identity
    /// providers through managed login and OIDC relying-party libraries. For more
    /// information,
    /// see [Third-party IdP
    /// sign-in](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: update_identity_provider.UpdateIdentityProviderInput, options: CallOptions) !update_identity_provider.UpdateIdentityProviderOutput {
        return update_identity_provider.execute(self, allocator, input, options);
    }

    /// Configures the branding settings for a user pool style. This operation is
    /// the
    /// programmatic option for the configuration of a style in the branding editor.
    ///
    /// Provides values for UI customization in a `Settings` JSON object and image
    /// files in an `Assets` array.
    ///
    /// This operation has a 2-megabyte request-size limit and include the CSS
    /// settings and
    /// image assets for your app client. Your branding settings might exceed 2MB in
    /// size. Amazon Cognito
    /// doesn't require that you pass all parameters in one request and preserves
    /// existing
    /// style settings that you don't specify. If your request is larger than 2MB,
    /// separate it
    /// into multiple requests, each with a size smaller than the limit.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateManagedLoginBranding(self: *Self, allocator: std.mem.Allocator, input: update_managed_login_branding.UpdateManagedLoginBrandingInput, options: CallOptions) !update_managed_login_branding.UpdateManagedLoginBrandingOutput {
        return update_managed_login_branding.execute(self, allocator, input, options);
    }

    /// Updates the name and scopes of a resource server. All other fields are
    /// read-only. For
    /// more information about resource servers, see [Access control with resource
    /// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
    ///
    /// If you don't provide a value for an attribute, it is set to the default
    /// value.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateResourceServer(self: *Self, allocator: std.mem.Allocator, input: update_resource_server.UpdateResourceServerInput, options: CallOptions) !update_resource_server.UpdateResourceServerOutput {
        return update_resource_server.execute(self, allocator, input, options);
    }

    /// Modifies existing terms documents for the requested app client. When Terms
    /// and
    /// conditions and Privacy policy documents are configured, the app client
    /// displays links to
    /// them in the sign-up page of managed login for the app client.
    ///
    /// You can provide URLs for terms documents in the languages that are supported
    /// by [managed login
    /// localization](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-localization). Amazon Cognito directs users to the terms documents for
    /// their current language, with fallback to `default` if no document exists for
    /// the language.
    ///
    /// Each request accepts one type of terms document and a map of
    /// language-to-link for that
    /// document type. You must provide both types of terms documents in at least
    /// one language
    /// before Amazon Cognito displays your terms documents. Supply each type in
    /// separate
    /// requests.
    ///
    /// For more information, see [Terms
    /// documents](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-terms-documents).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateTerms(self: *Self, allocator: std.mem.Allocator, input: update_terms.UpdateTermsInput, options: CallOptions) !update_terms.UpdateTermsOutput {
        return update_terms.execute(self, allocator, input, options);
    }

    /// Updates the currently signed-in user's attributes. To delete an attribute
    /// from
    /// the user, submit the attribute in your API request with a blank value.
    ///
    /// For custom attributes, you must add a `custom:` prefix to the attribute
    /// name, for example `custom:department`.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    pub fn updateUserAttributes(self: *Self, allocator: std.mem.Allocator, input: update_user_attributes.UpdateUserAttributesInput, options: CallOptions) !update_user_attributes.UpdateUserAttributesOutput {
        return update_user_attributes.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a user pool. To avoid setting parameters to
    /// Amazon Cognito
    /// defaults, construct this API request to pass the existing configuration of
    /// your user
    /// pool, modified to include the changes that you want to make.
    ///
    /// If you don't provide a value for an attribute, Amazon Cognito sets it to its
    /// default value.
    ///
    /// This action might generate an SMS text message. Starting June 1, 2021, US
    /// telecom carriers
    /// require you to register an origination phone number before you can send SMS
    /// messages
    /// to US phone numbers. If you use SMS text messages in Amazon Cognito, you
    /// must register a
    /// phone number with [Amazon
    /// Pinpoint](https://console.aws.amazon.com/pinpoint/home/).
    /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
    /// Cognito users who must
    /// receive SMS messages might not be able to sign up, activate their accounts,
    /// or sign
    /// in.
    ///
    /// If you have never used SMS text messages with Amazon Cognito or any other
    /// Amazon Web Services service,
    /// Amazon Simple Notification Service might place your account in the SMS
    /// sandbox. In *
    /// [sandbox
    /// mode](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html)
    /// *, you can send messages only to verified phone
    /// numbers. After you test your app while in the sandbox environment, you can
    /// move out
    /// of the sandbox and into production. For more information, see [ SMS message
    /// settings for Amazon Cognito user
    /// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html) in the *Amazon Cognito
    /// Developer Guide*.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateUserPool(self: *Self, allocator: std.mem.Allocator, input: update_user_pool.UpdateUserPoolInput, options: CallOptions) !update_user_pool.UpdateUserPoolOutput {
        return update_user_pool.execute(self, allocator, input, options);
    }

    /// Given a user pool app client ID, updates the configuration. To avoid setting
    /// parameters to Amazon Cognito defaults, construct this API request to pass
    /// the existing
    /// configuration of your app client, modified to include the changes that you
    /// want to
    /// make.
    ///
    /// If you don't provide a value for an attribute, Amazon Cognito sets it to its
    /// default value.
    ///
    /// Unlike app clients created in the console, Amazon Cognito doesn't
    /// automatically assign a
    /// branding style to app clients that you configure with this API operation.
    /// Managed login and classic hosted UI pages aren't
    /// available for your client until after you apply a branding style.
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateUserPoolClient(self: *Self, allocator: std.mem.Allocator, input: update_user_pool_client.UpdateUserPoolClientInput, options: CallOptions) !update_user_pool_client.UpdateUserPoolClientOutput {
        return update_user_pool_client.execute(self, allocator, input, options);
    }

    /// A user pool domain hosts managed login, an authorization server and web
    /// server for
    /// authentication in your application. This operation updates the branding
    /// version for user
    /// pool domains between `1` for hosted UI (classic) and `2` for
    /// managed login. It also updates the SSL certificate for user pool custom
    /// domains.
    ///
    /// Changes to the domain branding version take up to one minute to take effect
    /// for a
    /// prefix domain and up to five minutes for a custom domain.
    ///
    /// This operation doesn't change the name of your user pool domain. To change
    /// your
    /// domain, delete it with `DeleteUserPoolDomain` and create a new domain with
    /// `CreateUserPoolDomain`.
    ///
    /// You can pass the ARN of a new Certificate Manager certificate in this
    /// request. Typically, ACM
    /// certificates automatically renew and you user pool can continue to use the
    /// same ARN. But
    /// if you generate a new certificate for your custom domain name, replace the
    /// original
    /// configuration with the new ARN in this request.
    ///
    /// ACM certificates for custom domains must be in the US East (N. Virginia)
    /// Amazon Web Services Region. After you submit your request, Amazon Cognito
    /// requires up to 1 hour to distribute
    /// your new certificate to your custom domain.
    ///
    /// For more information about adding a custom domain to your user pool, see
    /// [Configuring a user pool
    /// domain](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html).
    ///
    /// Amazon Cognito evaluates Identity and Access Management (IAM) policies in
    /// requests for this API operation. For
    /// this operation, you must use IAM credentials to authorize requests, and you
    /// must
    /// grant yourself the corresponding IAM permission in a policy.
    ///
    /// **Learn more**
    ///
    /// * [Signing Amazon Web Services API
    ///   Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html)
    ///
    /// * [Using the Amazon Cognito user pools API and user pool
    ///   endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html)
    pub fn updateUserPoolDomain(self: *Self, allocator: std.mem.Allocator, input: update_user_pool_domain.UpdateUserPoolDomainInput, options: CallOptions) !update_user_pool_domain.UpdateUserPoolDomainOutput {
        return update_user_pool_domain.execute(self, allocator, input, options);
    }

    /// Registers the current user's time-based one-time password (TOTP)
    /// authenticator
    /// with a code generated in their authenticator app from a private key that's
    /// supplied
    /// by your user pool. Marks the user's software token MFA status as "verified"
    /// if
    /// successful. The request takes an access token or a session string, but not
    /// both.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn verifySoftwareToken(self: *Self, allocator: std.mem.Allocator, input: verify_software_token.VerifySoftwareTokenInput, options: CallOptions) !verify_software_token.VerifySoftwareTokenOutput {
        return verify_software_token.execute(self, allocator, input, options);
    }

    /// Submits a verification code for a signed-in user who has added or changed a
    /// value of
    /// an auto-verified attribute. When successful, the user's attribute becomes
    /// verified
    /// and the attribute `email_verified` or `phone_number_verified`
    /// becomes `true`.
    ///
    /// If your user pool requires verification before Amazon Cognito updates the
    /// attribute value,
    /// this operation updates the affected attribute to its pending value.
    ///
    /// Authorize this action with a signed-in user's access token. It must include
    /// the scope `aws.cognito.signin.user.admin`.
    ///
    /// Amazon Cognito doesn't evaluate Identity and Access Management (IAM)
    /// policies in requests for this API operation. For
    /// this operation, you can't use IAM credentials to authorize requests, and you
    /// can't
    /// grant IAM permissions in policies. For more information about authorization
    /// models in
    /// Amazon Cognito, see [Using the Amazon Cognito user pools API and user pool
    /// endpoints](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pools-API-operations.html).
    pub fn verifyUserAttribute(self: *Self, allocator: std.mem.Allocator, input: verify_user_attribute.VerifyUserAttributeInput, options: CallOptions) !verify_user_attribute.VerifyUserAttributeOutput {
        return verify_user_attribute.execute(self, allocator, input, options);
    }

    pub fn adminListGroupsForUserPaginator(self: *Self, params: admin_list_groups_for_user.AdminListGroupsForUserInput) paginator.AdminListGroupsForUserPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn adminListUserAuthEventsPaginator(self: *Self, params: admin_list_user_auth_events.AdminListUserAuthEventsInput) paginator.AdminListUserAuthEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIdentityProvidersPaginator(self: *Self, params: list_identity_providers.ListIdentityProvidersInput) paginator.ListIdentityProvidersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceServersPaginator(self: *Self, params: list_resource_servers.ListResourceServersInput) paginator.ListResourceServersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUserPoolClientsPaginator(self: *Self, params: list_user_pool_clients.ListUserPoolClientsInput) paginator.ListUserPoolClientsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUserPoolsPaginator(self: *Self, params: list_user_pools.ListUserPoolsInput) paginator.ListUserPoolsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUsersInGroupPaginator(self: *Self, params: list_users_in_group.ListUsersInGroupInput) paginator.ListUsersInGroupPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
