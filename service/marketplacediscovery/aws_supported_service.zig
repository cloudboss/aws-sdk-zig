/// Describes an AWS service supported by a fulfillment option.
pub const AwsSupportedService = struct {
    /// A description of the supported service.
    description: []const u8,

    /// The human-readable name of the supported service.
    display_name: []const u8,

    /// The machine-readable identifier of the supported service.
    supported_service_type: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .supported_service_type = "supportedServiceType",
    };
};
