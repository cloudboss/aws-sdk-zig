const AnalysisTemplateArtifact = @import("analysis_template_artifact.zig").AnalysisTemplateArtifact;

/// The analysis template artifacts.
pub const AnalysisTemplateArtifacts = struct {
    /// Additional artifacts for the analysis template.
    additional_artifacts: ?[]const AnalysisTemplateArtifact = null,

    /// The entry point for the analysis template artifacts.
    entry_point: AnalysisTemplateArtifact,

    /// The role ARN for the analysis template artifacts.
    role_arn: []const u8,

    pub const json_field_names = .{
        .additional_artifacts = "additionalArtifacts",
        .entry_point = "entryPoint",
        .role_arn = "roleArn",
    };
};
