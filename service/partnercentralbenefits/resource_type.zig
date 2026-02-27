pub const ResourceType = enum {
    opportunity,
    benefit_allocation,

    pub const json_field_names = .{
        .opportunity = "OPPORTUNITY",
        .benefit_allocation = "BENEFIT_ALLOCATION",
    };
};
