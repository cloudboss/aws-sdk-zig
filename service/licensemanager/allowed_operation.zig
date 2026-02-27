pub const AllowedOperation = enum {
    create_grant,
    checkout_license,
    checkout_borrow_license,
    check_in_license,
    extend_consumption_license,
    list_purchased_licenses,
    create_token,

    pub const json_field_names = .{
        .create_grant = "CREATE_GRANT",
        .checkout_license = "CHECKOUT_LICENSE",
        .checkout_borrow_license = "CHECKOUT_BORROW_LICENSE",
        .check_in_license = "CHECK_IN_LICENSE",
        .extend_consumption_license = "EXTEND_CONSUMPTION_LICENSE",
        .list_purchased_licenses = "LIST_PURCHASED_LICENSES",
        .create_token = "CREATE_TOKEN",
    };
};
