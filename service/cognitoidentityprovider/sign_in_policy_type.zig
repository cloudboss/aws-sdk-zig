const AuthFactorType = @import("auth_factor_type.zig").AuthFactorType;

/// The policy for allowed types of authentication in a user pool.
/// To activate this setting, your user pool must be in the [
/// Essentials
/// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
pub const SignInPolicyType = struct {
    /// The sign-in methods that a user pool supports as the first factor. You can
    /// permit
    /// users to start authentication with a standard username and password, or with
    /// other
    /// one-time password and hardware factors.
    allowed_first_auth_factors: ?[]const AuthFactorType,

    pub const json_field_names = .{
        .allowed_first_auth_factors = "AllowedFirstAuthFactors",
    };
};
