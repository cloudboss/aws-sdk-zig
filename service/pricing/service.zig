/// The metadata for a service, such as the service code and available attribute
/// names.
pub const Service = struct {
    /// The attributes that are available for this service.
    attribute_names: ?[]const []const u8 = null,

    /// The code for the Amazon Web Services service.
    service_code: []const u8,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .service_code = "ServiceCode",
    };
};
