pub const SavingsPlansDataType = enum {
    attributes,
    utilization,
    amortized_commitment,
    savings,

    pub const json_field_names = .{
        .attributes = "ATTRIBUTES",
        .utilization = "UTILIZATION",
        .amortized_commitment = "AMORTIZED_COMMITMENT",
        .savings = "SAVINGS",
    };
};
