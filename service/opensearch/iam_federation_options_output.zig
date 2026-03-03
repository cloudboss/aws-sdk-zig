/// Output parameters showing the current IAM identity federation configuration.
pub const IAMFederationOptionsOutput = struct {
    /// Indicates whether IAM identity federation is currently enabled for the
    /// domain.
    enabled: ?bool = null,

    /// The configured key in the SAML assertion for the user's role information.
    roles_key: ?[]const u8 = null,

    /// The configured key in the SAML assertion for the user's subject identifier.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
