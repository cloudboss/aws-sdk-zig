pub const BillingGroupType = enum {
    standard,
    transfer_billing,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .transfer_billing = "TRANSFER_BILLING",
    };
};
