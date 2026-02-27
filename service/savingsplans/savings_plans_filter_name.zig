pub const SavingsPlansFilterName = enum {
    region,
    ec2_instance_family,
    commitment,
    upfront,
    term,
    savings_plan_type,
    payment_option,
    start,
    end,
    instance_family,

    pub const json_field_names = .{
        .region = "REGION",
        .ec2_instance_family = "EC2_INSTANCE_FAMILY",
        .commitment = "COMMITMENT",
        .upfront = "UPFRONT",
        .term = "TERM",
        .savings_plan_type = "SAVINGS_PLAN_TYPE",
        .payment_option = "PAYMENT_OPTION",
        .start = "START",
        .end = "END",
        .instance_family = "INSTANCE_FAMILY",
    };
};
