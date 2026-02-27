pub const OutputLocationType = enum {
    customer_bucket,
    service_bucket,

    pub const json_field_names = .{
        .customer_bucket = "CUSTOMER_BUCKET",
        .service_bucket = "SERVICE_BUCKET",
    };
};
