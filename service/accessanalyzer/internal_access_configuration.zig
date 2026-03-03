const InternalAccessAnalysisRule = @import("internal_access_analysis_rule.zig").InternalAccessAnalysisRule;

/// Specifies the configuration of an internal access analyzer for an Amazon Web
/// Services organization or account. This configuration determines how the
/// analyzer evaluates internal access within your Amazon Web Services
/// environment.
pub const InternalAccessConfiguration = struct {
    /// Contains information about analysis rules for the internal access analyzer.
    /// These rules determine which resources and access patterns will be analyzed.
    analysis_rule: ?InternalAccessAnalysisRule = null,

    pub const json_field_names = .{
        .analysis_rule = "analysisRule",
    };
};
