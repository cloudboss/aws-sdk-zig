const RedshiftCredentials = @import("redshift_credentials.zig").RedshiftCredentials;
const RedshiftLineageSyncConfigurationOutput = @import("redshift_lineage_sync_configuration_output.zig").RedshiftLineageSyncConfigurationOutput;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;
const RedshiftStorageProperties = @import("redshift_storage_properties.zig").RedshiftStorageProperties;

/// The Amazon Redshift properties.
pub const RedshiftPropertiesOutput = struct {
    /// The Amazon Redshift credentials.
    credentials: ?RedshiftCredentials = null,

    /// The Amazon Redshift database name.
    database_name: ?[]const u8 = null,

    /// Specifies whether Amaon Redshift properties has a provisioned secret.
    is_provisioned_secret: ?bool = null,

    /// The jdbcIam URL of the Amazon Redshift properties.
    jdbc_iam_url: ?[]const u8 = null,

    /// The jdbcURL of the Amazon Redshift properties.
    jdbc_url: ?[]const u8 = null,

    /// The lineage syn of the Amazon Redshift properties.
    lineage_sync: ?RedshiftLineageSyncConfigurationOutput = null,

    /// The redshiftTempDir of the Amazon Redshift properties.
    redshift_temp_dir: ?[]const u8 = null,

    /// The status in the Amazon Redshift properties.
    status: ?ConnectionStatus = null,

    /// The storage in the Amazon Redshift properties.
    storage: ?RedshiftStorageProperties = null,

    pub const json_field_names = .{
        .credentials = "credentials",
        .database_name = "databaseName",
        .is_provisioned_secret = "isProvisionedSecret",
        .jdbc_iam_url = "jdbcIamUrl",
        .jdbc_url = "jdbcUrl",
        .lineage_sync = "lineageSync",
        .redshift_temp_dir = "redshiftTempDir",
        .status = "status",
        .storage = "storage",
    };
};
