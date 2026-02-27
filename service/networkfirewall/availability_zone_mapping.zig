/// Defines the mapping between an Availability Zone and a firewall endpoint for
/// a transit gateway-attached firewall. Each mapping represents where the
/// firewall can process traffic. You use these mappings when calling
/// CreateFirewall, AssociateAvailabilityZones, and
/// DisassociateAvailabilityZones.
///
/// To retrieve the current Availability Zone mappings for a firewall, use
/// DescribeFirewall.
pub const AvailabilityZoneMapping = struct {
    /// The ID of the Availability Zone where the firewall endpoint is located. For
    /// example, `us-east-2a`. The Availability Zone must be in the same Region as
    /// the transit gateway.
    availability_zone: []const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
    };
};
