pub const WorkloadEstimateRateType = enum {
    before_discounts,
    after_discounts,
    after_discounts_and_commitments,

    pub const json_field_names = .{
        .before_discounts = "BEFORE_DISCOUNTS",
        .after_discounts = "AFTER_DISCOUNTS",
        .after_discounts_and_commitments = "AFTER_DISCOUNTS_AND_COMMITMENTS",
    };
};
