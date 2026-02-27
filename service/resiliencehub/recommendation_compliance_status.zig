pub const RecommendationComplianceStatus = enum {
    breached_unattainable,
    breached_can_meet,
    met_can_improve,
    missing_policy,

    pub const json_field_names = .{
        .breached_unattainable = "BREACHED_UNATTAINABLE",
        .breached_can_meet = "BREACHED_CAN_MEET",
        .met_can_improve = "MET_CAN_IMPROVE",
        .missing_policy = "MISSING_POLICY",
    };
};
