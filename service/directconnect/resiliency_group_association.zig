const ResiliencyGroupAssociationState = @import("resiliency_group_association_state.zig").ResiliencyGroupAssociationState;

/// Information about an association between a connection and a resiliency
/// group.
pub const ResiliencyGroupAssociation = struct {
    /// The Amazon Resource Name (ARN) of the associated connection.
    connection_arn: ?[]const u8 = null,

    /// The ID of the resiliency group.
    resiliency_group_id: ?[]const u8 = null,

    /// The state of the association. The valid values are `associating`,
    /// `associated`, `disassociating`, and `disassociated`.
    state: ?ResiliencyGroupAssociationState = null,

    pub const json_field_names = .{
        .connection_arn = "connectionArn",
        .resiliency_group_id = "resiliencyGroupId",
        .state = "state",
    };
};
