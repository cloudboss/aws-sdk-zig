pub const RevenueModel = enum {
    contract,
    pay_as_you_go,
    subscription,

    pub const json_field_names = .{
        .contract = "CONTRACT",
        .pay_as_you_go = "PAY_AS_YOU_GO",
        .subscription = "SUBSCRIPTION",
    };
};
