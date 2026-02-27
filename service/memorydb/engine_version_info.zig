/// Provides details of the Redis OSS engine version
pub const EngineVersionInfo = struct {
    /// The name of the engine for which version information is provided.
    engine: ?[]const u8,

    /// The patched engine version
    engine_patch_version: ?[]const u8,

    /// The engine version
    engine_version: ?[]const u8,

    /// Specifies the name of the parameter group family to which the engine default
    /// parameters apply.
    parameter_group_family: ?[]const u8,

    pub const json_field_names = .{
        .engine = "Engine",
        .engine_patch_version = "EnginePatchVersion",
        .engine_version = "EngineVersion",
        .parameter_group_family = "ParameterGroupFamily",
    };
};
