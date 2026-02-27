const ManagedQueryResultsEncryptionConfiguration = @import("managed_query_results_encryption_configuration.zig").ManagedQueryResultsEncryptionConfiguration;

/// The configuration for storing results in Athena owned storage, which
/// includes whether this feature is enabled; whether encryption configuration,
/// if any, is used for encrypting query results.
pub const ManagedQueryResultsConfiguration = struct {
    /// If set to true, allows you to store query results in Athena owned storage.
    /// If set to
    /// false, workgroup member stores query results in location specified under
    /// `ResultConfiguration$OutputLocation`. The default is false. A workgroup
    /// cannot have the `ResultConfiguration$OutputLocation` parameter when you set
    /// this field to true.
    enabled: bool = false,

    /// If you encrypt query and calculation results in Athena owned storage, this
    /// field
    /// indicates the encryption option (for example, SSE_KMS or CSE_KMS) and key
    /// information.
    encryption_configuration: ?ManagedQueryResultsEncryptionConfiguration,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_configuration = "EncryptionConfiguration",
    };
};
