/// The risk for a given workload, lens review, pillar, or question.
pub const Risk = enum {
    unanswered,
    high,
    medium,
    none,
    not_applicable,

    pub const json_field_names = .{
        .unanswered = "UNANSWERED",
        .high = "HIGH",
        .medium = "MEDIUM",
        .none = "NONE",
        .not_applicable = "NOT_APPLICABLE",
    };
};
