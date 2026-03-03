const RelationalDatabaseEngine = @import("relational_database_engine.zig").RelationalDatabaseEngine;

/// Describes a database image, or blueprint. A blueprint describes the major
/// engine version
/// of a database.
pub const RelationalDatabaseBlueprint = struct {
    /// The ID for the database blueprint.
    blueprint_id: ?[]const u8 = null,

    /// The database software of the database blueprint (for example, `MySQL`).
    engine: ?RelationalDatabaseEngine = null,

    /// The description of the database engine for the database blueprint.
    engine_description: ?[]const u8 = null,

    /// The database engine version for the database blueprint (for example,
    /// `5.7.23`).
    engine_version: ?[]const u8 = null,

    /// The description of the database engine version for the database blueprint.
    engine_version_description: ?[]const u8 = null,

    /// A Boolean value indicating whether the engine version is the default for the
    /// database
    /// blueprint.
    is_engine_default: ?bool = null,

    pub const json_field_names = .{
        .blueprint_id = "blueprintId",
        .engine = "engine",
        .engine_description = "engineDescription",
        .engine_version = "engineVersion",
        .engine_version_description = "engineVersionDescription",
        .is_engine_default = "isEngineDefault",
    };
};
