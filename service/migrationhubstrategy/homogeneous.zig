const HomogeneousTargetDatabaseEngine = @import("homogeneous_target_database_engine.zig").HomogeneousTargetDatabaseEngine;

/// The object containing details about homogeneous database preferences.
pub const Homogeneous = struct {
    /// The target database engine for homogeneous database migration preferences.
    target_database_engine: ?[]const HomogeneousTargetDatabaseEngine = null,

    pub const json_field_names = .{
        .target_database_engine = "targetDatabaseEngine",
    };
};
