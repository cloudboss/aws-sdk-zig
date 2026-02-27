pub const AllocationType = enum {
    vpc_subnet,
    elastic_ip,
    overlay,
    unknown,

    pub const json_field_names = .{
        .vpc_subnet = "VPC_SUBNET",
        .elastic_ip = "ELASTIC_IP",
        .overlay = "OVERLAY",
        .unknown = "UNKNOWN",
    };
};
