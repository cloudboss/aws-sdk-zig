/// The version of the database engine that a DB instance can be upgraded to.
pub const UpgradeTarget = struct {
    /// A value that indicates whether the target version is applied to any source
    /// DB instances
    /// that have AutoMinorVersionUpgrade set to true.
    auto_upgrade: ?bool = null,

    /// The version of the database engine that a DB instance can be upgraded to.
    description: ?[]const u8 = null,

    /// The name of the upgrade target database engine.
    engine: ?[]const u8 = null,

    /// The version number of the upgrade target database engine.
    engine_version: ?[]const u8 = null,

    /// A value that indicates whether a database engine is upgraded to a major
    /// version.
    is_major_version_upgrade: ?bool = null,

    /// A value that indicates whether you can use Neptune global databases with the
    /// target engine version.
    supports_global_databases: ?bool = null,
};
