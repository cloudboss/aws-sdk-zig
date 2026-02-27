pub const AddressRoleType = enum {
    tax_address,
    billing_address,
    contact_address,

    pub const json_field_names = .{
        .tax_address = "TAX_ADDRESS",
        .billing_address = "BILLING_ADDRESS",
        .contact_address = "CONTACT_ADDRESS",
    };
};
