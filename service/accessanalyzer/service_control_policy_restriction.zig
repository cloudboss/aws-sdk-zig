pub const ServiceControlPolicyRestriction = enum {
    applicable,
    failed_to_evaluate_scp,
    not_applicable,
    applied,

    pub const json_field_names = .{
        .applicable = "APPLICABLE",
        .failed_to_evaluate_scp = "FAILED_TO_EVALUATE_SCP",
        .not_applicable = "NOT_APPLICABLE",
        .applied = "APPLIED",
    };
};
