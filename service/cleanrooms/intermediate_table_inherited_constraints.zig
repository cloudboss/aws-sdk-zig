const InheritedAdditionalAnalyses = @import("inherited_additional_analyses.zig").InheritedAdditionalAnalyses;
const InheritedAllowedAdditionalAnalyses = @import("inherited_allowed_additional_analyses.zig").InheritedAllowedAdditionalAnalyses;
const InheritedAllowedResultReceivers = @import("inherited_allowed_result_receivers.zig").InheritedAllowedResultReceivers;
const InheritedDisallowedOutputColumns = @import("inherited_disallowed_output_columns.zig").InheritedDisallowedOutputColumns;

/// Contains the privacy constraints inherited from parent tables for an
/// intermediate table version.
pub const IntermediateTableInheritedConstraints = struct {
    /// The inherited additional analyses constraint.
    additional_analyses: ?InheritedAdditionalAnalyses = null,

    /// The inherited allowed additional analyses constraint.
    allowed_additional_analyses: ?InheritedAllowedAdditionalAnalyses = null,

    /// The inherited allowed result receivers constraint.
    allowed_result_receivers: ?InheritedAllowedResultReceivers = null,

    /// The inherited disallowed output columns constraint.
    disallowed_output_columns: ?InheritedDisallowedOutputColumns = null,

    pub const json_field_names = .{
        .additional_analyses = "additionalAnalyses",
        .allowed_additional_analyses = "allowedAdditionalAnalyses",
        .allowed_result_receivers = "allowedResultReceivers",
        .disallowed_output_columns = "disallowedOutputColumns",
    };
};
