const IAMFederationOptionsOutput = @import("iam_federation_options_output.zig").IAMFederationOptionsOutput;
const JWTOptionsOutput = @import("jwt_options_output.zig").JWTOptionsOutput;
const SAMLOptionsOutput = @import("saml_options_output.zig").SAMLOptionsOutput;

/// Container for fine-grained access control settings.
pub const AdvancedSecurityOptions = struct {
    /// Date and time when the migration period will be disabled. Only necessary
    /// when [enabling fine-grained access control on an existing
    /// domain](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-enabling-existing).
    anonymous_auth_disable_date: ?i64,

    /// True if a 30-day migration period is enabled, during which administrators
    /// can create
    /// role mappings. Only necessary when [enabling fine-grained access control on
    /// an existing
    /// domain](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-enabling-existing).
    anonymous_auth_enabled: ?bool,

    /// True if fine-grained access control is enabled.
    enabled: ?bool,

    /// Configuration options for IAM identity federation in advanced security
    /// settings.
    iam_federation_options: ?IAMFederationOptionsOutput,

    /// True if the internal user database is enabled.
    internal_user_database_enabled: ?bool,

    /// Container for information about the JWT configuration of the Amazon
    /// OpenSearch
    /// Service.
    jwt_options: ?JWTOptionsOutput,

    /// Container for information about the SAML configuration for OpenSearch
    /// Dashboards.
    saml_options: ?SAMLOptionsOutput,

    pub const json_field_names = .{
        .anonymous_auth_disable_date = "AnonymousAuthDisableDate",
        .anonymous_auth_enabled = "AnonymousAuthEnabled",
        .enabled = "Enabled",
        .iam_federation_options = "IAMFederationOptions",
        .internal_user_database_enabled = "InternalUserDatabaseEnabled",
        .jwt_options = "JWTOptions",
        .saml_options = "SAMLOptions",
    };
};
