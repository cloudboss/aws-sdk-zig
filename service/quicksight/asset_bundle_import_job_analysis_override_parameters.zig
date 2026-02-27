/// The override parameters for a single analysis that is being imported.
pub const AssetBundleImportJobAnalysisOverrideParameters = struct {
    /// The ID of the analysis that you ant to apply overrides to.
    analysis_id: []const u8,

    /// A new name for the analysis.
    name: ?[]const u8,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .name = "Name",
    };
};
