const AnalysisTemplateArtifactMetadata = @import("analysis_template_artifact_metadata.zig").AnalysisTemplateArtifactMetadata;

/// The analysis source metadata.
pub const AnalysisSourceMetadata = union(enum) {
    /// The artifacts of the analysis source metadata.
    artifacts: ?AnalysisTemplateArtifactMetadata,

    pub const json_field_names = .{
        .artifacts = "artifacts",
    };
};
