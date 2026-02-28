const IamFederationConfigOptions = @import("iam_federation_config_options.zig").IamFederationConfigOptions;
const IamIdentityCenterConfigOptions = @import("iam_identity_center_config_options.zig").IamIdentityCenterConfigOptions;
const SamlConfigOptions = @import("saml_config_options.zig").SamlConfigOptions;
const SecurityConfigType = @import("security_config_type.zig").SecurityConfigType;

/// Details about a security configuration for OpenSearch Serverless.
pub const SecurityConfigDetail = struct {
    /// The version of the security configuration.
    config_version: ?[]const u8,

    /// The date the configuration was created.
    created_date: ?i64,

    /// The description of the security configuration.
    description: ?[]const u8,

    /// Describes IAM federation options in the form of a key-value map. Contains
    /// configuration details about how OpenSearch Serverless integrates with
    /// external identity providers through federation.
    iam_federation_options: ?IamFederationConfigOptions,

    /// Describes IAM Identity Center options in the form of a key-value map.
    iam_identity_center_options: ?IamIdentityCenterConfigOptions,

    /// The unique identifier of the security configuration.
    id: ?[]const u8,

    /// The timestamp of when the configuration was last modified.
    last_modified_date: ?i64,

    /// SAML options for the security configuration in the form of a key-value map.
    saml_options: ?SamlConfigOptions,

    /// The type of security configuration.
    @"type": ?SecurityConfigType,

    pub const json_field_names = .{
        .config_version = "configVersion",
        .created_date = "createdDate",
        .description = "description",
        .iam_federation_options = "iamFederationOptions",
        .iam_identity_center_options = "iamIdentityCenterOptions",
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .saml_options = "samlOptions",
        .@"type" = "type",
    };
};
