/// The Athena engine version for running queries, or the PySpark engine
/// version for running sessions.
pub const EngineVersion = struct {
    /// Read only. The engine version on which the query runs. If the user requests
    /// a valid
    /// engine version other than Auto, the effective engine version is the same as
    /// the engine
    /// version that the user requested. If the user requests Auto, the effective
    /// engine version
    /// is chosen by Athena. When a request to update the engine version is made by
    /// a `CreateWorkGroup` or `UpdateWorkGroup` operation, the
    /// `EffectiveEngineVersion` field is ignored.
    effective_engine_version: ?[]const u8,

    /// The engine version requested by the user. Possible values are determined by
    /// the output
    /// of `ListEngineVersions`, including AUTO. The default is AUTO.
    selected_engine_version: ?[]const u8,

    pub const json_field_names = .{
        .effective_engine_version = "EffectiveEngineVersion",
        .selected_engine_version = "SelectedEngineVersion",
    };
};
