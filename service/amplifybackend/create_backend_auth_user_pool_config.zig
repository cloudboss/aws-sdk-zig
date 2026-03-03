const CreateBackendAuthForgotPasswordConfig = @import("create_backend_auth_forgot_password_config.zig").CreateBackendAuthForgotPasswordConfig;
const CreateBackendAuthMFAConfig = @import("create_backend_auth_mfa_config.zig").CreateBackendAuthMFAConfig;
const CreateBackendAuthOAuthConfig = @import("create_backend_auth_o_auth_config.zig").CreateBackendAuthOAuthConfig;
const CreateBackendAuthPasswordPolicyConfig = @import("create_backend_auth_password_policy_config.zig").CreateBackendAuthPasswordPolicyConfig;
const RequiredSignUpAttributesElement = @import("required_sign_up_attributes_element.zig").RequiredSignUpAttributesElement;
const SignInMethod = @import("sign_in_method.zig").SignInMethod;
const CreateBackendAuthVerificationMessageConfig = @import("create_backend_auth_verification_message_config.zig").CreateBackendAuthVerificationMessageConfig;

/// Describes the Amazon Cognito user pool configuration for the auth resource
/// to be configured for your Amplify project.
pub const CreateBackendAuthUserPoolConfig = struct {
    /// **(DEPRECATED)** Describes the forgotten password policy for your Amazon
    /// Cognito user pool, configured as a part of your Amplify project.
    forgot_password: ?CreateBackendAuthForgotPasswordConfig = null,

    /// Describes whether to apply multi-factor authentication policies for your
    /// Amazon Cognito user pool configured as a part of your Amplify project.
    mfa: ?CreateBackendAuthMFAConfig = null,

    /// Describes the OAuth policy and rules for your Amazon Cognito user pool,
    /// configured as a part of your Amplify project.
    o_auth: ?CreateBackendAuthOAuthConfig = null,

    /// Describes the password policy for your Amazon Cognito user pool, configured
    /// as a part of your Amplify project.
    password_policy: ?CreateBackendAuthPasswordPolicyConfig = null,

    /// The required attributes to sign up new users in the user pool.
    required_sign_up_attributes: []const RequiredSignUpAttributesElement,

    /// Describes the sign-in methods that your Amplify app users use to log in
    /// using the Amazon Cognito user pool, configured as a part of your Amplify
    /// project.
    sign_in_method: SignInMethod,

    /// The Amazon Cognito user pool name.
    user_pool_name: []const u8,

    /// Describes the email or SMS verification message for your Amazon Cognito user
    /// pool, configured as a part of your Amplify project.
    verification_message: ?CreateBackendAuthVerificationMessageConfig = null,

    pub const json_field_names = .{
        .forgot_password = "ForgotPassword",
        .mfa = "Mfa",
        .o_auth = "OAuth",
        .password_policy = "PasswordPolicy",
        .required_sign_up_attributes = "RequiredSignUpAttributes",
        .sign_in_method = "SignInMethod",
        .user_pool_name = "UserPoolName",
        .verification_message = "VerificationMessage",
    };
};
