const ManagedQueryResultsEncryptionConfiguration = @import("managed_query_results_encryption_configuration.zig").ManagedQueryResultsEncryptionConfiguration;

/// Updates the configuration for managed query results.
pub const ManagedQueryResultsConfigurationUpdates = struct {
    /// If set to true, specifies that Athena manages query results in Athena owned
    /// storage.
    enabled: ?bool = null,

    /// If you encrypt query and calculation results in Athena owned storage, this
    /// field
    /// indicates the encryption option (for example, SSE_KMS or CSE_KMS) and key
    /// information.
    encryption_configuration: ?ManagedQueryResultsEncryptionConfiguration = null,

    /// If set to true, it removes workgroup from Athena owned storage. The existing
    /// query
    /// results are cleaned up after 24hrs. You must provide query results in
    /// location specified
    /// under `ResultConfiguration$OutputLocation`.
    remove_encryption_configuration: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_configuration = "EncryptionConfiguration",
        .remove_encryption_configuration = "RemoveEncryptionConfiguration",
    };
};
