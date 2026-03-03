const AnalysisSourceTemplate = @import("analysis_source_template.zig").AnalysisSourceTemplate;

/// The source entity of an analysis.
pub const AnalysisSourceEntity = struct {
    /// The source template for the source entity of the analysis.
    source_template: ?AnalysisSourceTemplate = null,

    pub const json_field_names = .{
        .source_template = "SourceTemplate",
    };
};
