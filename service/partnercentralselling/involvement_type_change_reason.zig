pub const InvolvementTypeChangeReason = enum {
    expansion_opportunity,
    change_in_deal_information,
    customer_requested,
    technical_complexity,
    risk_mitigation,

    pub const json_field_names = .{
        .expansion_opportunity = "EXPANSION_OPPORTUNITY",
        .change_in_deal_information = "CHANGE_IN_DEAL_INFORMATION",
        .customer_requested = "CUSTOMER_REQUESTED",
        .technical_complexity = "TECHNICAL_COMPLEXITY",
        .risk_mitigation = "RISK_MITIGATION",
    };
};
