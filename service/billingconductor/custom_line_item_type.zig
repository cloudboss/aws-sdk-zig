pub const CustomLineItemType = enum {
    credit,
    fee,

    pub const json_field_names = .{
        .credit = "CREDIT",
        .fee = "FEE",
    };
};
