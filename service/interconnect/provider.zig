/// Describes the respective AWS Interconnect Partner organization.
pub const Provider = union(enum) {
    /// The provider's name. Specifically, connections to/from this Cloud Service
    /// Provider will be considered Multicloud connections.
    cloud_service_provider: ?[]const u8,
    /// The provider's name. Specifically, connections to/from this Last Mile
    /// Provider will be considered LastMile connections.
    last_mile_provider: ?[]const u8,

    pub const json_field_names = .{
        .cloud_service_provider = "cloudServiceProvider",
        .last_mile_provider = "lastMileProvider",
    };
};
