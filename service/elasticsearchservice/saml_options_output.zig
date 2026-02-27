const SAMLIdp = @import("saml_idp.zig").SAMLIdp;

/// Describes the SAML application configured for the domain.
pub const SAMLOptionsOutput = struct {
    /// True if SAML is enabled.
    enabled: ?bool,

    /// Describes the SAML Identity Provider's information.
    idp: ?SAMLIdp,

    /// The key used for matching the SAML Roles attribute.
    roles_key: ?[]const u8,

    /// The duration, in minutes, after which a user session becomes inactive.
    session_timeout_minutes: ?i32,

    /// The key used for matching the SAML Subject attribute.
    subject_key: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .idp = "Idp",
        .roles_key = "RolesKey",
        .session_timeout_minutes = "SessionTimeoutMinutes",
        .subject_key = "SubjectKey",
    };
};
