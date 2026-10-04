const IAMConfiguration = @import("iam_configuration.zig").IAMConfiguration;
const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;

/// Contains the authentication settings for a security configuration, including
/// Identity Center and IAM configuration options.
pub const AuthenticationConfiguration = struct {
    /// The IAM configuration to use for authentication.
    iam_configuration: ?IAMConfiguration = null,

    /// The IAM Identity Center configuration to use for authentication.
    identity_center_configuration: ?IdentityCenterConfiguration = null,

    pub const json_field_names = .{
        .iam_configuration = "iamConfiguration",
        .identity_center_configuration = "identityCenterConfiguration",
    };
};
