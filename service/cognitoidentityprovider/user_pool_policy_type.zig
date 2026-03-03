const PasswordPolicyType = @import("password_policy_type.zig").PasswordPolicyType;
const SignInPolicyType = @import("sign_in_policy_type.zig").SignInPolicyType;

/// A list of user pool policies. Contains the policy that sets
/// password-complexity
/// requirements.
pub const UserPoolPolicyType = struct {
    /// The password policy settings for a user pool, including complexity, history,
    /// and
    /// length requirements.
    password_policy: ?PasswordPolicyType = null,

    /// The policy for allowed types of authentication in a user pool.
    sign_in_policy: ?SignInPolicyType = null,

    pub const json_field_names = .{
        .password_policy = "PasswordPolicy",
        .sign_in_policy = "SignInPolicy",
    };
};
