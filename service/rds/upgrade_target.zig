/// The version of the database engine that a DB instance can be upgraded to.
pub const UpgradeTarget = struct {
    /// Indicates whether the target version is applied to any source DB instances
    /// that have `AutoMinorVersionUpgrade` set to true.
    ///
    /// This parameter is dynamic, and is set by RDS.
    auto_upgrade: ?bool = null,

    /// The version of the database engine that a DB instance can be upgraded to.
    description: ?[]const u8 = null,

    /// The name of the upgrade target database engine.
    engine: ?[]const u8 = null,

    /// The version number of the upgrade target database engine.
    engine_version: ?[]const u8 = null,

    /// Indicates whether upgrading to the target version requires upgrading the
    /// major version of the database engine.
    is_major_version_upgrade: ?bool = null,

    /// A list of the supported DB engine modes for the target engine version.
    supported_engine_modes: ?[]const []const u8 = null,

    /// Indicates whether you can use Babelfish for Aurora PostgreSQL with the
    /// target engine version.
    supports_babelfish: ?bool = null,

    /// Indicates whether you can use Aurora global databases with the target engine
    /// version.
    supports_global_databases: ?bool = null,

    /// Indicates whether the DB engine version supports zero-ETL integrations with
    /// Amazon Redshift.
    supports_integrations: ?bool = null,

    /// Indicates whether the DB engine version supports Aurora Limitless Database.
    supports_limitless_database: ?bool = null,

    /// Indicates whether the target engine version supports forwarding write
    /// operations from reader DB instances to the writer DB instance in the DB
    /// cluster. By default, write operations aren't allowed on reader DB instances.
    ///
    /// Valid for: Aurora DB clusters only
    supports_local_write_forwarding: ?bool = null,

    /// Indicates whether you can use Aurora parallel query with the target engine
    /// version.
    supports_parallel_query: ?bool = null,
};
