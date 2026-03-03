const RedshiftCredentialConfiguration = @import("redshift_credential_configuration.zig").RedshiftCredentialConfiguration;
const RedshiftStorage = @import("redshift_storage.zig").RedshiftStorage;
const RelationalFilterConfiguration = @import("relational_filter_configuration.zig").RelationalFilterConfiguration;

/// The configuration details of the Amazon Redshift data source.
pub const RedshiftRunConfigurationInput = struct {
    /// The data access role included in the configuration details of the Amazon
    /// Redshift data source.
    data_access_role: ?[]const u8 = null,

    redshift_credential_configuration: ?RedshiftCredentialConfiguration = null,

    redshift_storage: ?RedshiftStorage = null,

    /// The relational filger configurations included in the configuration details
    /// of the Amazon Redshift data source.
    relational_filter_configurations: []const RelationalFilterConfiguration,

    pub const json_field_names = .{
        .data_access_role = "dataAccessRole",
        .redshift_credential_configuration = "redshiftCredentialConfiguration",
        .redshift_storage = "redshiftStorage",
        .relational_filter_configurations = "relationalFilterConfigurations",
    };
};
