const RouteTableAssociationState = @import("route_table_association_state.zig").RouteTableAssociationState;

/// Describes an association between a route table and a subnet or gateway.
pub const RouteTableAssociation = struct {
    /// The state of the association.
    association_state: ?RouteTableAssociationState = null,

    /// The ID of the internet gateway or virtual private gateway.
    gateway_id: ?[]const u8 = null,

    /// Indicates whether this is the main route table.
    main: ?bool = null,

    /// The ID of a public IPv4 pool. A public IPv4 pool is a pool of IPv4 addresses
    /// that you've brought to Amazon Web Services with BYOIP.
    public_ipv_4_pool: ?[]const u8 = null,

    /// The ID of the association.
    route_table_association_id: ?[]const u8 = null,

    /// The ID of the route table.
    route_table_id: ?[]const u8 = null,

    /// The ID of the subnet. A subnet ID is not returned for an implicit
    /// association.
    subnet_id: ?[]const u8 = null,
};
