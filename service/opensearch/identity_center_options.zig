const RolesKeyIdCOption = @import("roles_key_id_c_option.zig").RolesKeyIdCOption;
const SubjectKeyIdCOption = @import("subject_key_id_c_option.zig").SubjectKeyIdCOption;

/// Settings container for integrating IAM Identity Center with OpenSearch UI
/// applications,
/// which enables enabling secure user authentication and access control across
/// multiple data
/// sources. This setup supports single sign-on (SSO) through IAM Identity
/// Center, allowing
/// centralized user management.
pub const IdentityCenterOptions = struct {
    /// Indicates whether IAM Identity Center is enabled for the application.
    enabled_api_access: ?bool = null,

    /// The ARN of the IAM Identity Center application that integrates with Amazon
    /// OpenSearch
    /// Service.
    identity_center_application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance.
    identity_center_instance_arn: ?[]const u8 = null,

    /// The identifier of the IAM Identity Store.
    identity_store_id: ?[]const u8 = null,

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
        .identity_center_application_arn = "IdentityCenterApplicationARN",
        .identity_center_instance_arn = "IdentityCenterInstanceARN",
        .identity_store_id = "IdentityStoreId",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
