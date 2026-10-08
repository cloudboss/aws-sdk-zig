const ExtendedAnalysisMode = @import("extended_analysis_mode.zig").ExtendedAnalysisMode;
const SummaryGenerationMode = @import("summary_generation_mode.zig").SummaryGenerationMode;

/// The output configuration settings for the contextual metadata feature. Use
/// this structure when the feed output generates metadata that describes the
/// media content.
pub const ContextualMetadataConfig = struct {
    /// Specifies whether Elemental Inference generates extended analysis of the
    /// media content for this output. Extended analysis identifies the people,
    /// environments, brands, and on-screen text in the media content. This setting
    /// is independent of `summaryGeneration`.
    ///
    /// Valid values:
    ///
    /// * ENABLED (default) – Elemental Inference populates the people,
    ///   environments, brands, and on-screen text fields.
    /// * DISABLED – Elemental Inference doesn't populate the people, environments,
    ///   brands, and on-screen text fields.
    extended_analysis: ?ExtendedAnalysisMode = null,

    /// Specifies whether Elemental Inference generates a descriptive summary of the
    /// media content for this output, along with the objects and actions that it
    /// detects. This setting is independent of `extendedAnalysis`.
    ///
    /// Valid values:
    ///
    /// * ENABLED (default) – Elemental Inference populates the summary, objects,
    ///   and actions fields, along with the IAB taxonomy and GARM suitability
    ///   classifications.
    /// * DISABLED – Elemental Inference doesn't populate the summary, objects, and
    ///   actions fields.
    summary_generation: ?SummaryGenerationMode = null,

    pub const json_field_names = .{
        .extended_analysis = "extendedAnalysis",
        .summary_generation = "summaryGeneration",
    };
};
