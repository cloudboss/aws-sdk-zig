/// An object that contains configuration settings for the matching process in a
/// rule-based matching workflow.
pub const MatchingConfig = struct {
    /// Enables transitive matching for the rule-based matching workflow. When
    /// enabled, records that match through different rules are grouped together
    /// into the same match group.
    enable_transitive_matching: ?bool = null,

    pub const json_field_names = .{
        .enable_transitive_matching = "enableTransitiveMatching",
    };
};
