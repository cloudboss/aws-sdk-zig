pub const ServiceType = enum {
    rds,
    docdb,

    pub const json_field_names = .{
        .rds = "RDS",
        .docdb = "DOCDB",
    };
};
