const KxDatabaseCacheConfiguration = @import("kx_database_cache_configuration.zig").KxDatabaseCacheConfiguration;
const KxDataviewConfiguration = @import("kx_dataview_configuration.zig").KxDataviewConfiguration;

/// The configuration of data that is available for querying from this database.
pub const KxDatabaseConfiguration = struct {
    /// Configuration details for the disk cache used to increase performance
    /// reading from a kdb database mounted to the cluster.
    cache_configurations: ?[]const KxDatabaseCacheConfiguration = null,

    /// A unique identifier of the changeset that is associated with the cluster.
    changeset_id: ?[]const u8 = null,

    /// The name of the kdb database. When this parameter is specified in the
    /// structure, S3 with the whole database is included by default.
    database_name: []const u8,

    /// The configuration of the dataview to be used with specified cluster.
    dataview_configuration: ?KxDataviewConfiguration = null,

    /// The name of the dataview to be used for caching historical data on disk.
    dataview_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_configurations = "cacheConfigurations",
        .changeset_id = "changesetId",
        .database_name = "databaseName",
        .dataview_configuration = "dataviewConfiguration",
        .dataview_name = "dataviewName",
    };
};
