const CharacterSet = @import("character_set.zig").CharacterSet;
const Timezone = @import("timezone.zig").Timezone;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;

/// This data type is used as a response element in the action
/// DescribeDBEngineVersions.
pub const DBEngineVersion = struct {
    /// The description of the database engine.
    db_engine_description: ?[]const u8,

    /// The description of the database engine version.
    db_engine_version_description: ?[]const u8,

    /// The name of the DB parameter group family for the database engine.
    db_parameter_group_family: ?[]const u8,

    /// *(Not supported by Neptune)*
    default_character_set: ?CharacterSet,

    /// The name of the database engine.
    engine: ?[]const u8,

    /// The version number of the database engine.
    engine_version: ?[]const u8,

    /// The types of logs that the database engine has available for export to
    /// CloudWatch
    /// Logs.
    exportable_log_types: ?[]const []const u8,

    /// *(Not supported by Neptune)*
    supported_character_sets: ?[]const CharacterSet,

    /// A list of the time zones supported by this engine for the `Timezone`
    /// parameter
    /// of the `CreateDBInstance` action.
    supported_timezones: ?[]const Timezone,

    /// A value that indicates whether you can use Aurora global databases with a
    /// specific DB engine version.
    supports_global_databases: ?bool,

    /// A value that indicates whether the engine version supports exporting the log
    /// types
    /// specified by ExportableLogTypes to CloudWatch Logs.
    supports_log_exports_to_cloudwatch_logs: ?bool,

    /// Indicates whether the database engine version supports read replicas.
    supports_read_replica: ?bool,

    /// A list of engine versions that this database engine version can be upgraded
    /// to.
    valid_upgrade_target: ?[]const UpgradeTarget,
};
