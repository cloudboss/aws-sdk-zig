const SAMLIdp = @import("saml_idp.zig").SAMLIdp;

/// Specifies the SAML application configuration for the domain.
pub const SAMLOptionsInput = struct {
    /// True if SAML is enabled.
    enabled: ?bool = null,

    /// Specifies the SAML Identity Provider's information.
    idp: ?SAMLIdp = null,

    /// The backend role to which the SAML master user is mapped to.
    master_backend_role: ?[]const u8 = null,

    /// The SAML master username, which is stored in the Amazon Elasticsearch
    /// Service domain's internal database.
    master_user_name: ?[]const u8 = null,

    /// The key to use for matching the SAML Roles attribute.
    roles_key: ?[]const u8 = null,

    /// The duration, in minutes, after which a user session becomes inactive.
    /// Acceptable values are between 1 and 1440, and the default value is 60.
    session_timeout_minutes: ?i32 = null,

    /// The key to use for matching the SAML Subject attribute.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .idp = "Idp",
        .master_backend_role = "MasterBackendRole",
        .master_user_name = "MasterUserName",
        .roles_key = "RolesKey",
        .session_timeout_minutes = "SessionTimeoutMinutes",
        .subject_key = "SubjectKey",
    };
};
