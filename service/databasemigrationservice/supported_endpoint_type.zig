const ReplicationEndpointTypeValue = @import("replication_endpoint_type_value.zig").ReplicationEndpointTypeValue;

/// Provides information about types of supported endpoints in response to a
/// request by the
/// `DescribeEndpointTypes` operation. This information includes the type of
/// endpoint, the database engine name, and whether change data capture (CDC) is
/// supported.
pub const SupportedEndpointType = struct {
    /// The type of endpoint. Valid values are `source` and
    /// `target`.
    endpoint_type: ?ReplicationEndpointTypeValue = null,

    /// The expanded name for the engine name. For example, if the `EngineName`
    /// parameter is "aurora", this value would be "Amazon Aurora MySQL".
    engine_display_name: ?[]const u8 = null,

    /// The database engine name. Valid values, depending on the EndpointType,
    /// include
    /// `"mysql"`, `"oracle"`, `"postgres"`,
    /// `"mariadb"`, `"aurora"`, `"aurora-postgresql"`,
    /// `"redshift"`, `"s3"`, `"db2"`, `"db2-zos"`,
    /// `"azuredb"`, `"sybase"`, `"dynamodb"`,
    /// `"mongodb"`, `"kinesis"`, `"kafka"`,
    /// `"elasticsearch"`, `"documentdb"`, `"sqlserver"`,
    /// `"neptune"`, and `"babelfish"`.
    engine_name: ?[]const u8 = null,

    /// The earliest DMS engine version that supports this endpoint engine. Note
    /// that endpoint
    /// engines released with DMS versions earlier than 3.1.1 do not return a value
    /// for this
    /// parameter.
    replication_instance_engine_minimum_version: ?[]const u8 = null,

    /// Indicates if change data capture (CDC) is supported.
    supports_cdc: bool = false,

    pub const json_field_names = .{
        .endpoint_type = "EndpointType",
        .engine_display_name = "EngineDisplayName",
        .engine_name = "EngineName",
        .replication_instance_engine_minimum_version = "ReplicationInstanceEngineMinimumVersion",
        .supports_cdc = "SupportsCDC",
    };
};
