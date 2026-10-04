const InheritanceMode = @import("inheritance_mode.zig").InheritanceMode;

/// The per-scan-type inheritance reset settings for the `UpdateConfiguration`
/// operation. Each member is independently optional. Including a member in this
/// structure
/// resets that scan type's configuration to inherit from the delegated
/// administrator.
pub const UpdateConfigurationInheritance = struct {
    /// The inheritance mode for Amazon EC2 scan configuration. Set to
    /// `INHERIT_FROM_ADMIN` to reset the member account's Amazon EC2 scan
    /// configuration to
    /// inherit from the delegated administrator. If omitted, the member account's
    /// existing Amazon EC2
    /// scan configuration is not changed.
    ec_2_configuration: ?InheritanceMode = null,

    /// The inheritance mode for Amazon ECR scan configuration. Set to
    /// `INHERIT_FROM_ADMIN` to reset the member account's Amazon ECR scan
    /// configuration to
    /// inherit from the delegated administrator. If omitted, the member account's
    /// existing Amazon ECR
    /// scan configuration is not changed.
    ecr_configuration: ?InheritanceMode = null,

    pub const json_field_names = .{
        .ec_2_configuration = "ec2Configuration",
        .ecr_configuration = "ecrConfiguration",
    };
};
