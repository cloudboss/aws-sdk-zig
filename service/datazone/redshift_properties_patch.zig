const RedshiftCredentials = @import("redshift_credentials.zig").RedshiftCredentials;
const RedshiftLineageSyncConfigurationInput = @import("redshift_lineage_sync_configuration_input.zig").RedshiftLineageSyncConfigurationInput;
const RedshiftStorageProperties = @import("redshift_storage_properties.zig").RedshiftStorageProperties;

/// Amazon Redshift properties patch.
pub const RedshiftPropertiesPatch = struct {
    /// The credentials in the Amazon Redshift properties patch.
    credentials: ?RedshiftCredentials = null,

    /// The name in the Amazon Redshift properties patch.
    database_name: ?[]const u8 = null,

    /// The host in the Amazon Redshift properties patch.
    host: ?[]const u8 = null,

    /// The lineage sync in the Amazon Redshift properties patch.
    lineage_sync: ?RedshiftLineageSyncConfigurationInput = null,

    /// The port in the Amazon Redshift properties patch.
    port: ?i32 = null,

    /// The storage in the Amazon Redshift properties patch.
    storage: ?RedshiftStorageProperties = null,

    pub const json_field_names = .{
        .credentials = "credentials",
        .database_name = "databaseName",
        .host = "host",
        .lineage_sync = "lineageSync",
        .port = "port",
        .storage = "storage",
    };
};
