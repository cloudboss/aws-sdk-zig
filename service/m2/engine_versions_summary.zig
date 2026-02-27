/// A subset of information about the engine version for a specific application.
pub const EngineVersionsSummary = struct {
    /// The type of target platform for the application.
    engine_type: []const u8,

    /// The version of the engine type used by the application.
    engine_version: []const u8,

    pub const json_field_names = .{
        .engine_type = "engineType",
        .engine_version = "engineVersion",
    };
};
