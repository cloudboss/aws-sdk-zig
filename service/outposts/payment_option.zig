pub const PaymentOption = enum {
    all_upfront,
    no_upfront,
    partial_upfront,

    pub const json_field_names = .{
        .all_upfront = "ALL_UPFRONT",
        .no_upfront = "NO_UPFRONT",
        .partial_upfront = "PARTIAL_UPFRONT",
    };
};
