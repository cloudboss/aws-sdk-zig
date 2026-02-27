pub const ResourceControlPolicyRestriction = enum {
    applicable,
    failed_to_evaluate_rcp,
    not_applicable,
    applied,

    pub const json_field_names = .{
        .applicable = "APPLICABLE",
        .failed_to_evaluate_rcp = "FAILED_TO_EVALUATE_RCP",
        .not_applicable = "NOT_APPLICABLE",
        .applied = "APPLIED",
    };
};
