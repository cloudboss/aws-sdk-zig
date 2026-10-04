const InheritedAllowedAdditionalAnalysesSource = @import("inherited_allowed_additional_analyses_source.zig").InheritedAllowedAdditionalAnalysesSource;

/// Contains the inherited allowed additional analyses constraint and its
/// sources from parent tables.
pub const InheritedAllowedAdditionalAnalyses = struct {
    /// The list of parent tables that contribute to this inherited constraint.
    sources: []const InheritedAllowedAdditionalAnalysesSource,

    /// The effective list of allowed additional analyses inherited from parent
    /// tables.
    value: []const []const u8,

    pub const json_field_names = .{
        .sources = "sources",
        .value = "value",
    };
};
