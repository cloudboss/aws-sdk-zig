pub const FulfillmentType = enum {
    credits,
    cash,
    access,

    pub const json_field_names = .{
        .credits = "CREDITS",
        .cash = "CASH",
        .access = "ACCESS",
    };
};
