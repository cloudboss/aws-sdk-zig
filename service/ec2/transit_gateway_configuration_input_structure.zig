/// The Transit Gateway configuration for a Client VPN endpoint.
pub const TransitGatewayConfigurationInputStructure = struct {
    /// The Availability Zone IDs for the Transit Gateway association. You can
    /// specify up to the maximum number of Availability Zones supported by the
    /// Transit Gateway. You cannot specify both `AvailabilityZones` and
    /// `AvailabilityZoneIds`.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The Availability Zone names for the Transit Gateway association. You can
    /// specify up to the maximum number of Availability Zones supported by the
    /// Transit Gateway. You cannot specify both `AvailabilityZones` and
    /// `AvailabilityZoneIds`.
    availability_zones: ?[]const []const u8 = null,

    /// The ID of the Transit Gateway to associate with the Client VPN endpoint.
    transit_gateway_id: ?[]const u8 = null,
};
