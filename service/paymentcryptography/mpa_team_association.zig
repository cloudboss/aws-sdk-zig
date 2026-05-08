const MpaOperation = @import("mpa_operation.zig").MpaOperation;
const AssociationState = @import("association_state.zig").AssociationState;
const MpaStatus = @import("mpa_status.zig").MpaStatus;

/// The details of an MPA team association with a protected operation.
pub const MpaTeamAssociation = struct {
    /// The protected operation associated with the MPA team.
    action: MpaOperation,

    /// The state of the MPA team association.
    association_state: AssociationState,

    /// The MPA session status for the association, if applicable.
    mpa_status: ?MpaStatus = null,

    /// The ARN of the MPA team.
    mpa_team_arn: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .association_state = "AssociationState",
        .mpa_status = "MpaStatus",
        .mpa_team_arn = "MpaTeamArn",
    };
};
