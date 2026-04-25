const RolesKeyIdCOption = @import("roles_key_id_c_option.zig").RolesKeyIdCOption;
const SubjectKeyIdCOption = @import("subject_key_id_c_option.zig").SubjectKeyIdCOption;

/// Configuration settings for enabling and managing IAM Identity Center.
pub const IdentityCenterOptionsInput = struct {
    /// Indicates whether IAM Identity Center is enabled for API access in Amazon
    /// OpenSearch
    /// Service.
    enabled_api_access: ?bool = null,

    /// The ARN of the IAM Identity Center instance used to create an OpenSearch UI
    /// application that
    /// uses IAM Identity Center for authentication.
    identity_center_instance_arn: ?[]const u8 = null,

    /// The Region of the IAM Identity Center instance.
    identity_center_instance_region: ?[]const u8 = null,

    /// Specifies the attribute that contains the backend role identifier (such as
    /// group name or
    /// group ID) in IAM Identity Center.
    roles_key: ?RolesKeyIdCOption = null,

    /// Specifies the attribute that contains the subject identifier (such as
    /// username, user ID, or
    /// email) in IAM Identity Center.
    subject_key: ?SubjectKeyIdCOption = null,

    pub const json_field_names = .{
        .enabled_api_access = "EnabledAPIAccess",
        .identity_center_instance_arn = "IdentityCenterInstanceARN",
        .identity_center_instance_region = "IdentityCenterInstanceRegion",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
