pub const ThroughputMode = enum {
    pay_per_request,
    provisioned,

    pub const json_field_names = .{
        .pay_per_request = "PAY_PER_REQUEST",
        .provisioned = "PROVISIONED",
    };
};
