const DatabaseColumnList = @import("database_column_list.zig").DatabaseColumnList;
const DatabaseList = @import("database_list.zig").DatabaseList;
const DatabaseSourceAuthenticationConfiguration = @import("database_source_authentication_configuration.zig").DatabaseSourceAuthenticationConfiguration;
const DatabaseSourceVPCConfiguration = @import("database_source_vpc_configuration.zig").DatabaseSourceVPCConfiguration;
const SSLMode = @import("ssl_mode.zig").SSLMode;
const DatabaseTableList = @import("database_table_list.zig").DatabaseTableList;
const DatabaseType = @import("database_type.zig").DatabaseType;

/// The top level object for configuring streams with database as a source.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const DatabaseSourceConfiguration = struct {
    /// The list of column patterns in source database endpoint for Firehose to read
    /// from.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    columns: ?DatabaseColumnList,

    /// The list of database patterns in source database endpoint for Firehose to
    /// read from.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    databases: DatabaseList,

    /// The structure to configure the authentication methods for Firehose to
    /// connect to source database endpoint.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    database_source_authentication_configuration: DatabaseSourceAuthenticationConfiguration,

    /// The details of the VPC Endpoint Service which Firehose uses to create a
    /// PrivateLink to the database.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    database_source_vpc_configuration: DatabaseSourceVPCConfiguration,

    /// The endpoint of the database server.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    endpoint: []const u8,

    /// The port of the database. This can be one of the following values.
    ///
    /// * 3306 for MySQL database type
    ///
    /// * 5432 for PostgreSQL database type
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    port: i32,

    /// The fully qualified name of the table in source database endpoint that
    /// Firehose uses to track snapshot progress.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    snapshot_watermark_table: []const u8,

    /// The mode to enable or disable SSL when Firehose connects to the database
    /// endpoint.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    ssl_mode: ?SSLMode,

    /// The optional list of table and column names used as unique key columns when
    /// taking snapshot if the tables don’t have primary keys configured.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    surrogate_keys: ?[]const []const u8,

    /// The list of table patterns in source database endpoint for Firehose to read
    /// from.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    tables: DatabaseTableList,

    /// The type of database engine. This can be one of the following values.
    ///
    /// * MySQL
    ///
    /// * PostgreSQL
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    type: DatabaseType,

    pub const json_field_names = .{
        .columns = "Columns",
        .databases = "Databases",
        .database_source_authentication_configuration = "DatabaseSourceAuthenticationConfiguration",
        .database_source_vpc_configuration = "DatabaseSourceVPCConfiguration",
        .endpoint = "Endpoint",
        .port = "Port",
        .snapshot_watermark_table = "SnapshotWatermarkTable",
        .ssl_mode = "SSLMode",
        .surrogate_keys = "SurrogateKeys",
        .tables = "Tables",
        .type = "Type",
    };
};
