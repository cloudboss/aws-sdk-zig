pub const VpcEndpointManagement = enum {
    customer,
    service,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .service = "SERVICE",
    };
};
