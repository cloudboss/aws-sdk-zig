pub const ServicePeriodType = enum {
    minimum_notice_period,
    fixed_commitment_period,

    pub const json_field_names = .{
        .minimum_notice_period = "MINIMUM_NOTICE_PERIOD",
        .fixed_commitment_period = "FIXED_COMMITMENT_PERIOD",
    };
};
