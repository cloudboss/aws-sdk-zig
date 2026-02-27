const ConfigurationPolicyAssociation = @import("configuration_policy_association.zig").ConfigurationPolicyAssociation;

/// An array of configuration policy associations, one for each configuration
/// policy association identifier, that
/// was specified in a `BatchGetConfigurationPolicyAssociations` request but
/// couldn’t be processed due
/// to an error.
pub const UnprocessedConfigurationPolicyAssociation = struct {
    /// Configuration policy association identifiers that were specified in a
    /// `BatchGetConfigurationPolicyAssociations`
    /// request but couldn’t be processed due to an error.
    configuration_policy_association_identifiers: ?ConfigurationPolicyAssociation,

    /// An HTTP status code that identifies why the configuration policy association
    /// failed.
    error_code: ?[]const u8,

    /// A string that identifies why the configuration policy association failed.
    error_reason: ?[]const u8,

    pub const json_field_names = .{
        .configuration_policy_association_identifiers = "ConfigurationPolicyAssociationIdentifiers",
        .error_code = "ErrorCode",
        .error_reason = "ErrorReason",
    };
};
