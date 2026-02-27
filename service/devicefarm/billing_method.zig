pub const BillingMethod = enum {
    metered,
    unmetered,

    pub const json_field_names = .{
        .metered = "METERED",
        .unmetered = "UNMETERED",
    };
};
