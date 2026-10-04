/// Contains the IAM Identity Center settings for a security configuration,
/// including instance ARN, application assignment requirements, and application
/// ARN.
pub const IdentityCenterConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EMR Identity Center
    /// application.
    emr_identity_center_application_arn: ?[]const u8 = null,

    /// Specifies whether Identity Center is enabled for the security configuration.
    enable_identity_center: ?bool = null,

    /// Specifies whether user assignment is required for the Identity Center
    /// application.
    identity_center_application_assignment_required: ?bool = null,

    /// The Amazon Resource Name (ARN) of the Identity Center instance.
    identity_center_instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .emr_identity_center_application_arn = "emrIdentityCenterApplicationARN",
        .enable_identity_center = "enableIdentityCenter",
        .identity_center_application_assignment_required = "identityCenterApplicationAssignmentRequired",
        .identity_center_instance_arn = "identityCenterInstanceARN",
    };
};
