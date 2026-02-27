pub const PermissionType = enum {
    /// Customer Managed
    customer_managed,
    /// Service Managed
    service_managed,

    pub const json_field_names = .{
        .customer_managed = "CUSTOMER_MANAGED",
        .service_managed = "SERVICE_MANAGED",
    };
};
