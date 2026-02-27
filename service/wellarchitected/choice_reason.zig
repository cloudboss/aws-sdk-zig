pub const ChoiceReason = enum {
    out_of_scope,
    business_priorities,
    architecture_constraints,
    other,
    none,

    pub const json_field_names = .{
        .out_of_scope = "OUT_OF_SCOPE",
        .business_priorities = "BUSINESS_PRIORITIES",
        .architecture_constraints = "ARCHITECTURE_CONSTRAINTS",
        .other = "OTHER",
        .none = "NONE",
    };
};
