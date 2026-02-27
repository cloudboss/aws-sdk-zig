pub const AppSecurityGroupManagement = enum {
    service,
    customer,

    pub const json_field_names = .{
        .service = "Service",
        .customer = "Customer",
    };
};
