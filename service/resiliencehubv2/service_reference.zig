/// A reference to a service by ID and name.
pub const ServiceReference = struct {
    /// The identifier of the referenced service.
    service_id: ?[]const u8 = null,

    /// The name of the referenced service.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_id = "serviceId",
        .service_name = "serviceName",
    };
};
