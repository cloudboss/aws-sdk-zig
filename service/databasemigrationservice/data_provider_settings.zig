const DocDbDataProviderSettings = @import("doc_db_data_provider_settings.zig").DocDbDataProviderSettings;
const IbmDb2LuwDataProviderSettings = @import("ibm_db_2_luw_data_provider_settings.zig").IbmDb2LuwDataProviderSettings;
const IbmDb2zOsDataProviderSettings = @import("ibm_db_2_z_os_data_provider_settings.zig").IbmDb2zOsDataProviderSettings;
const MariaDbDataProviderSettings = @import("maria_db_data_provider_settings.zig").MariaDbDataProviderSettings;
const MicrosoftSqlServerDataProviderSettings = @import("microsoft_sql_server_data_provider_settings.zig").MicrosoftSqlServerDataProviderSettings;
const MongoDbDataProviderSettings = @import("mongo_db_data_provider_settings.zig").MongoDbDataProviderSettings;
const MySqlDataProviderSettings = @import("my_sql_data_provider_settings.zig").MySqlDataProviderSettings;
const OracleDataProviderSettings = @import("oracle_data_provider_settings.zig").OracleDataProviderSettings;
const PostgreSqlDataProviderSettings = @import("postgre_sql_data_provider_settings.zig").PostgreSqlDataProviderSettings;
const RedshiftDataProviderSettings = @import("redshift_data_provider_settings.zig").RedshiftDataProviderSettings;
const SybaseAseDataProviderSettings = @import("sybase_ase_data_provider_settings.zig").SybaseAseDataProviderSettings;

/// Provides information that defines a data provider.
pub const DataProviderSettings = union(enum) {
    doc_db_settings: ?DocDbDataProviderSettings,
    /// Provides information that defines an IBM DB2 LUW data provider.
    ibm_db_2_luw_settings: ?IbmDb2LuwDataProviderSettings,
    /// Provides information that defines an IBM DB2 for z/OS data provider.
    ibm_db_2_z_os_settings: ?IbmDb2zOsDataProviderSettings,
    /// Provides information that defines a MariaDB data provider.
    maria_db_settings: ?MariaDbDataProviderSettings,
    microsoft_sql_server_settings: ?MicrosoftSqlServerDataProviderSettings,
    /// Provides information that defines a MongoDB data provider.
    mongo_db_settings: ?MongoDbDataProviderSettings,
    my_sql_settings: ?MySqlDataProviderSettings,
    oracle_settings: ?OracleDataProviderSettings,
    postgre_sql_settings: ?PostgreSqlDataProviderSettings,
    redshift_settings: ?RedshiftDataProviderSettings,
    sybase_ase_settings: ?SybaseAseDataProviderSettings,

    pub const json_field_names = .{
        .doc_db_settings = "DocDbSettings",
        .ibm_db_2_luw_settings = "IbmDb2LuwSettings",
        .ibm_db_2_z_os_settings = "IbmDb2zOsSettings",
        .maria_db_settings = "MariaDbSettings",
        .microsoft_sql_server_settings = "MicrosoftSqlServerSettings",
        .mongo_db_settings = "MongoDbSettings",
        .my_sql_settings = "MySqlSettings",
        .oracle_settings = "OracleSettings",
        .postgre_sql_settings = "PostgreSqlSettings",
        .redshift_settings = "RedshiftSettings",
        .sybase_ase_settings = "SybaseAseSettings",
    };
};
