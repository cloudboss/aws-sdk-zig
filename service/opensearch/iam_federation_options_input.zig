/// Input parameters for configuring IAM identity federation settings.
pub const IAMFederationOptionsInput = struct {
    /// Specifies whether IAM identity federation is enabled for the OpenSearch
    /// domain.
    enabled: ?bool = null,

    /// The key in the SAML assertion that contains the user's role information.
    roles_key: ?[]const u8 = null,

    /// The key in the SAML assertion that contains the user's subject identifier.
    subject_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .roles_key = "RolesKey",
        .subject_key = "SubjectKey",
    };
};
