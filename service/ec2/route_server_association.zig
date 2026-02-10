const RouteServerAssociationState = @import("route_server_association_state.zig").RouteServerAssociationState;

/// Describes the association between a route server and a VPC.
///
/// A route server association is the connection established between a route
/// server and a VPC.
pub const RouteServerAssociation = struct {
    /// The ID of the associated route server.
    route_server_id: ?[]const u8,

    /// The current state of the association.
    state: ?RouteServerAssociationState,

    /// The ID of the associated VPC.
    vpc_id: ?[]const u8,
};
