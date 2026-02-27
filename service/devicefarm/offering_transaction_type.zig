pub const OfferingTransactionType = enum {
    purchase,
    renew,
    system,

    pub const json_field_names = .{
        .purchase = "PURCHASE",
        .renew = "RENEW",
        .system = "SYSTEM",
    };
};
