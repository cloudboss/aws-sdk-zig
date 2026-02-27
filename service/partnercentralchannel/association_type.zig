pub const AssociationType = enum {
    downstream_seller,
    end_customer,
    internal,

    pub const json_field_names = .{
        .downstream_seller = "DOWNSTREAM_SELLER",
        .end_customer = "END_CUSTOMER",
        .internal = "INTERNAL",
    };
};
