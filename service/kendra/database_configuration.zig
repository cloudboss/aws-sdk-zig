const AclConfiguration = @import("acl_configuration.zig").AclConfiguration;
const ColumnConfiguration = @import("column_configuration.zig").ColumnConfiguration;
const ConnectionConfiguration = @import("connection_configuration.zig").ConnectionConfiguration;
const DatabaseEngineType = @import("database_engine_type.zig").DatabaseEngineType;
const SqlConfiguration = @import("sql_configuration.zig").SqlConfiguration;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to an [Amazon Kendra supported
/// database](https://docs.aws.amazon.com/kendra/latest/dg/data-source-database.html).
pub const DatabaseConfiguration = struct {
    /// Information about the database column that provides information for user
    /// context
    /// filtering.
    acl_configuration: ?AclConfiguration,

    /// Information about where the index should get the document information from
    /// the
    /// database.
    column_configuration: ColumnConfiguration,

    /// Configuration information that's required to connect to a database.
    connection_configuration: ConnectionConfiguration,

    /// The type of database engine that runs the database.
    database_engine_type: DatabaseEngineType,

    /// Provides information about how Amazon Kendra uses quote marks around SQL
    /// identifiers when querying a database data source.
    sql_configuration: ?SqlConfiguration,

    vpc_configuration: ?DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .acl_configuration = "AclConfiguration",
        .column_configuration = "ColumnConfiguration",
        .connection_configuration = "ConnectionConfiguration",
        .database_engine_type = "DatabaseEngineType",
        .sql_configuration = "SqlConfiguration",
        .vpc_configuration = "VpcConfiguration",
    };
};
