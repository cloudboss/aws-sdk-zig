const SAMLIdp = @import("saml_idp.zig").SAMLIdp;

/// Describes the SAML application configured for the domain.
pub const SAMLOptionsOutput = struct {
    /// True if SAML is enabled.
    enabled: ?bool,

    /// Describes the SAML identity provider's information.
    idp: ?SAMLIdp,

    /// The key used for matching the SAML roles attribute.
    roles_key: ?[]const u8,

    /// The duration, in minutes, after which a user session becomes inactive.
    session_timeout_minutes: ?i32,

    /// The key used for matching the SAML subject attribute.
    subject_key: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .idp = "Idp",
        .roles_key = "RolesKey",
        .session_timeout_minutes = "SessionTimeoutMinutes",
        .subject_key = "SubjectKey",
    };
};
