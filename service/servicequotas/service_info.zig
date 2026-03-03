/// Information about an Amazon Web Services service.
pub const ServiceInfo = struct {
    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: ?[]const u8 = null,

    /// Specifies the service name.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_code = "ServiceCode",
        .service_name = "ServiceName",
    };
};
