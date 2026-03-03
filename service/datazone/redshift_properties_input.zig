const RedshiftCredentials = @import("redshift_credentials.zig").RedshiftCredentials;
const RedshiftLineageSyncConfigurationInput = @import("redshift_lineage_sync_configuration_input.zig").RedshiftLineageSyncConfigurationInput;
const RedshiftStorageProperties = @import("redshift_storage_properties.zig").RedshiftStorageProperties;

/// The Amazon Redshift properties.
pub const RedshiftPropertiesInput = struct {
    /// The Amaon Redshift credentials.
    credentials: ?RedshiftCredentials = null,

    /// The Amazon Redshift database name.
    database_name: ?[]const u8 = null,

    /// The Amazon Redshift host.
    host: ?[]const u8 = null,

    /// The lineage sync of the Amazon Redshift.
    lineage_sync: ?RedshiftLineageSyncConfigurationInput = null,

    /// The Amaon Redshift port.
    port: ?i32 = null,

    /// The Amazon Redshift storage.
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
