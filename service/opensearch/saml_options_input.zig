const SAMLIdp = @import("saml_idp.zig").SAMLIdp;

/// The SAML authentication configuration for an Amazon OpenSearch Service
/// domain.
pub const SAMLOptionsInput = struct {
    /// True to enable SAML authentication for a domain.
    enabled: ?bool = null,

    /// The SAML Identity Provider's information.
    idp: ?SAMLIdp = null,

    /// The backend role that the SAML master user is mapped to.
    master_backend_role: ?[]const u8 = null,

    /// The SAML master user name, which is stored in the domain's internal user
    /// database.
    master_user_name: ?[]const u8 = null,

    /// Element of the SAML assertion to use for backend roles. Default is
    /// `roles`.
    roles_key: ?[]const u8 = null,

    /// The duration, in minutes, after which a user session becomes inactive.
    /// Acceptable
    /// values are between 1 and 1440, and the default value is 60.
    session_timeout_minutes: ?i32 = null,

    /// Element of the SAML assertion to use for the user name. Default is
    /// `NameID`.
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
