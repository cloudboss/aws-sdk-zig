/// The IAM Identity Center Configuration accepts the Identity Center instance
/// parameter required to enable trusted identity propagation. This
/// configuration allows identity propagation between integrated services and
/// the Identity Center instance.
pub const IdentityCenterConfigurationInput = struct {
    /// The ARN of the IAM Identity Center instance.
    identity_center_instance_arn: ?[]const u8 = null,

    /// Enables user background sessions for this application so Livy sessions can
    /// continue running after users log out of their interactive notebook or their
    /// Identity Center sessions expire.
    user_background_sessions_enabled: ?bool = null,

    pub const json_field_names = .{
        .identity_center_instance_arn = "identityCenterInstanceArn",
        .user_background_sessions_enabled = "userBackgroundSessionsEnabled",
    };
};
