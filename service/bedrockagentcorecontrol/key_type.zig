pub const KeyType = enum {
    customer_managed_key,
    service_managed_key,

    pub const json_field_names = .{
        .customer_managed_key = "CustomerManagedKey",
        .service_managed_key = "ServiceManagedKey",
    };
};
