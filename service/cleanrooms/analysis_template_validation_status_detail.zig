const AnalysisTemplateValidationStatusReason = @import("analysis_template_validation_status_reason.zig").AnalysisTemplateValidationStatusReason;
const AnalysisTemplateValidationStatus = @import("analysis_template_validation_status.zig").AnalysisTemplateValidationStatus;
const AnalysisTemplateValidationType = @import("analysis_template_validation_type.zig").AnalysisTemplateValidationType;

/// The status details of the analysis template validation. Clean Rooms
/// Differential Privacy uses a general-purpose query structure to support
/// complex SQL queries and validates whether an analysis template fits that
/// general-purpose query structure. Validation is performed when analysis
/// templates are created and fetched. Because analysis templates are immutable
/// by design, we recommend that you create analysis templates after you
/// associate the configured tables with their analysis rule to your
/// collaboration.
///
/// For more information, see
/// [https://docs.aws.amazon.com/clean-rooms/latest/userguide/analysis-rules-custom.html#custom-diff-privacy](https://docs.aws.amazon.com/clean-rooms/latest/userguide/analysis-rules-custom.html#custom-diff-privacy).
pub const AnalysisTemplateValidationStatusDetail = struct {
    /// The reasons for the validation results.
    reasons: ?[]const AnalysisTemplateValidationStatusReason,

    /// The status of the validation.
    status: AnalysisTemplateValidationStatus,

    /// The type of validation that was performed.
    @"type": AnalysisTemplateValidationType,

    pub const json_field_names = .{
        .reasons = "reasons",
        .status = "status",
        .@"type" = "type",
    };
};
