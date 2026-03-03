const UpdateBackendAuthForgotPasswordConfig = @import("update_backend_auth_forgot_password_config.zig").UpdateBackendAuthForgotPasswordConfig;
const UpdateBackendAuthMFAConfig = @import("update_backend_auth_mfa_config.zig").UpdateBackendAuthMFAConfig;
const UpdateBackendAuthOAuthConfig = @import("update_backend_auth_o_auth_config.zig").UpdateBackendAuthOAuthConfig;
const UpdateBackendAuthPasswordPolicyConfig = @import("update_backend_auth_password_policy_config.zig").UpdateBackendAuthPasswordPolicyConfig;
const UpdateBackendAuthVerificationMessageConfig = @import("update_backend_auth_verification_message_config.zig").UpdateBackendAuthVerificationMessageConfig;

/// Describes the Amazon Cognito user pool configuration for the authorization
/// resource to be configured for your Amplify project on an update.
pub const UpdateBackendAuthUserPoolConfig = struct {
    /// **(DEPRECATED)** Describes the forgot password policy for your Amazon
    /// Cognito user pool, configured as a part of your Amplify project.
    forgot_password: ?UpdateBackendAuthForgotPasswordConfig = null,

    /// Describes whether to apply multi-factor authentication policies for your
    /// Amazon Cognito user pool configured as a part of your Amplify project.
    mfa: ?UpdateBackendAuthMFAConfig = null,

    /// Describes the OAuth policy and rules for your Amazon Cognito user pool,
    /// configured as a part of your Amplify project.
    o_auth: ?UpdateBackendAuthOAuthConfig = null,

    /// Describes the password policy for your Amazon Cognito user pool, configured
    /// as a part of your Amplify project.
    password_policy: ?UpdateBackendAuthPasswordPolicyConfig = null,

    /// Describes the email or SMS verification message for your Amazon Cognito user
    /// pool, configured as a part of your Amplify project.
    verification_message: ?UpdateBackendAuthVerificationMessageConfig = null,

    pub const json_field_names = .{
        .forgot_password = "ForgotPassword",
        .mfa = "Mfa",
        .o_auth = "OAuth",
        .password_policy = "PasswordPolicy",
        .verification_message = "VerificationMessage",
    };
};
