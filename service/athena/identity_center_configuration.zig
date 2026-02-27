/// Specifies whether the workgroup is IAM Identity Center supported.
pub const IdentityCenterConfiguration = struct {
    /// Specifies whether the workgroup is IAM Identity Center supported.
    enable_identity_center: ?bool,

    /// The IAM Identity Center instance ARN that the workgroup associates to.
    identity_center_instance_arn: ?[]const u8,

    pub const json_field_names = .{
        .enable_identity_center = "EnableIdentityCenter",
        .identity_center_instance_arn = "IdentityCenterInstanceArn",
    };
};
