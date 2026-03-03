const RdsHttpEndpointConfig = @import("rds_http_endpoint_config.zig").RdsHttpEndpointConfig;
const RelationalDatabaseSourceType = @import("relational_database_source_type.zig").RelationalDatabaseSourceType;

/// Describes a relational database data source configuration.
pub const RelationalDatabaseDataSourceConfig = struct {
    /// Amazon RDS HTTP endpoint settings.
    rds_http_endpoint_config: ?RdsHttpEndpointConfig = null,

    /// Source type for the relational database.
    ///
    /// * **RDS_HTTP_ENDPOINT**: The relational database
    /// source type is an Amazon Relational Database Service (Amazon RDS) HTTP
    /// endpoint.
    relational_database_source_type: ?RelationalDatabaseSourceType = null,

    pub const json_field_names = .{
        .rds_http_endpoint_config = "rdsHttpEndpointConfig",
        .relational_database_source_type = "relationalDatabaseSourceType",
    };
};
