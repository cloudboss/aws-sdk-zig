/// An Elastic IP address association with the elastic network interface in the
/// VLAN subnet.
pub const EipAssociation = struct {
    /// The Elastic IP address allocation ID.
    allocation_id: ?[]const u8,

    /// A unique ID for the elastic IP address association with the VLAN subnet.
    association_id: ?[]const u8,

    /// The Elastic IP address.
    ip_address: ?[]const u8,

    pub const json_field_names = .{
        .allocation_id = "allocationId",
        .association_id = "associationId",
        .ip_address = "ipAddress",
    };
};
