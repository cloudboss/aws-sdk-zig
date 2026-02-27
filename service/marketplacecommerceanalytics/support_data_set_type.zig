pub const SupportDataSetType = enum {
    customer_support_contacts_data,
    test_customer_support_contacts_data,

    pub const json_field_names = .{
        .customer_support_contacts_data = "customer_support_contacts_data",
        .test_customer_support_contacts_data = "test_customer_support_contacts_data",
    };
};
