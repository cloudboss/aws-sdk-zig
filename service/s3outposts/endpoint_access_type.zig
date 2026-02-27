pub const EndpointAccessType = enum {
    private,
    customer_owned_ip,

    pub const json_field_names = .{
        .private = "PRIVATE",
        .customer_owned_ip = "CUSTOMER_OWNED_IP",
    };
};
