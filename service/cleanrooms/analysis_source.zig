const AnalysisTemplateArtifacts = @import("analysis_template_artifacts.zig").AnalysisTemplateArtifacts;

/// The structure that defines the body of the analysis template.
pub const AnalysisSource = union(enum) {
    /// The artifacts of the analysis source.
    artifacts: ?AnalysisTemplateArtifacts,
    /// The query text.
    text: ?[]const u8,

    pub const json_field_names = .{
        .artifacts = "artifacts",
        .text = "text",
    };
};
