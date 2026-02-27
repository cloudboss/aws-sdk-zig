const TargetDatabaseEngine = @import("target_database_engine.zig").TargetDatabaseEngine;

/// The object containing details about database migration preferences, when you
/// have no
/// particular preference.
pub const NoDatabaseMigrationPreference = struct {
    /// The target database engine for database migration preference that you
    /// specify.
    target_database_engine: []const TargetDatabaseEngine,

    pub const json_field_names = .{
        .target_database_engine = "targetDatabaseEngine",
    };
};
