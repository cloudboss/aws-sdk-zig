const HeterogeneousTargetDatabaseEngine = @import("heterogeneous_target_database_engine.zig").HeterogeneousTargetDatabaseEngine;

/// The object containing details about heterogeneous database preferences.
pub const Heterogeneous = struct {
    /// The target database engine for heterogeneous database migration preference.
    target_database_engine: []const HeterogeneousTargetDatabaseEngine,

    pub const json_field_names = .{
        .target_database_engine = "targetDatabaseEngine",
    };
};
