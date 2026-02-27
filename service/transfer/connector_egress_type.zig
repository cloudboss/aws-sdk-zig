pub const ConnectorEgressType = enum {
    service_managed,
    vpc_lattice,

    pub const json_field_names = .{
        .service_managed = "SERVICE_MANAGED",
        .vpc_lattice = "VPC_LATTICE",
    };
};
