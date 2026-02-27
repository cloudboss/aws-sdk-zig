/// Type of contextual grounding filter
pub const GuardrailContextualGroundingFilterType = enum {
    grounding,
    relevance,

    pub const json_field_names = .{
        .grounding = "GROUNDING",
        .relevance = "RELEVANCE",
    };
};
