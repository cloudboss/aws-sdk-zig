pub const ServiceType = enum {
    redshift,
    qbusiness,
    athena,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .qbusiness = "QBUSINESS",
        .athena = "ATHENA",
    };
};
