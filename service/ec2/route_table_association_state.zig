const RouteTableAssociationStateCode = @import("route_table_association_state_code.zig").RouteTableAssociationStateCode;

/// Describes the state of an association between a route table and a subnet or
/// gateway.
pub const RouteTableAssociationState = struct {
    /// The state of the association.
    state: ?RouteTableAssociationStateCode,

    /// The status message, if applicable.
    status_message: ?[]const u8,
};
