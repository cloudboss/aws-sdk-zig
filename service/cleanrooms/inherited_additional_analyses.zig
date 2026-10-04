const InheritedAdditionalAnalysesSource = @import("inherited_additional_analyses_source.zig").InheritedAdditionalAnalysesSource;
const AdditionalAnalyses = @import("additional_analyses.zig").AdditionalAnalyses;

/// Contains the inherited additional analyses constraint and its sources from
/// parent tables.
pub const InheritedAdditionalAnalyses = struct {
    /// The list of parent tables that contribute to this inherited constraint.
    sources: []const InheritedAdditionalAnalysesSource,

    /// The effective additional analyses setting inherited from parent tables.
    value: AdditionalAnalyses,

    pub const json_field_names = .{
        .sources = "sources",
        .value = "value",
    };
};
