pub const ServiceNetworkLogType = enum {
    /// Indicates logs for Lattice services.
    service,
    /// Indicates logs for Lattice resource configurations.
    resource,

    pub const json_field_names = .{
        .service = "SERVICE",
        .resource = "RESOURCE",
    };
};
