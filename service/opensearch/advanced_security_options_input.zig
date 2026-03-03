const IAMFederationOptionsInput = @import("iam_federation_options_input.zig").IAMFederationOptionsInput;
const JWTOptionsInput = @import("jwt_options_input.zig").JWTOptionsInput;
const MasterUserOptions = @import("master_user_options.zig").MasterUserOptions;
const SAMLOptionsInput = @import("saml_options_input.zig").SAMLOptionsInput;

/// Options for enabling and configuring fine-grained access control. For more
/// information, see [Fine-grained access control
/// in Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html).
pub const AdvancedSecurityOptionsInput = struct {
    /// True to enable a 30-day migration period during which administrators can
    /// create role
    /// mappings. Only necessary when [enabling fine-grained access control on an
    /// existing
    /// domain](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-enabling-existing).
    anonymous_auth_enabled: ?bool = null,

    /// True to enable fine-grained access control.
    enabled: ?bool = null,

    /// Input configuration for IAM identity federation within advanced security
    /// options.
    iam_federation_options: ?IAMFederationOptionsInput = null,

    /// True to enable the internal user database.
    internal_user_database_enabled: ?bool = null,

    /// Container for information about the JWT configuration of the Amazon
    /// OpenSearch
    /// Service.
    jwt_options: ?JWTOptionsInput = null,

    /// Container for information about the master user.
    master_user_options: ?MasterUserOptions = null,

    /// Container for information about the SAML configuration for OpenSearch
    /// Dashboards.
    saml_options: ?SAMLOptionsInput = null,

    pub const json_field_names = .{
        .anonymous_auth_enabled = "AnonymousAuthEnabled",
        .enabled = "Enabled",
        .iam_federation_options = "IAMFederationOptions",
        .internal_user_database_enabled = "InternalUserDatabaseEnabled",
        .jwt_options = "JWTOptions",
        .master_user_options = "MasterUserOptions",
        .saml_options = "SAMLOptions",
    };
};
