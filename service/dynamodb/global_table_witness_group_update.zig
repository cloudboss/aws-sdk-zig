const CreateGlobalTableWitnessGroupMemberAction = @import("create_global_table_witness_group_member_action.zig").CreateGlobalTableWitnessGroupMemberAction;
const DeleteGlobalTableWitnessGroupMemberAction = @import("delete_global_table_witness_group_member_action.zig").DeleteGlobalTableWitnessGroupMemberAction;

/// Represents one of the following:
///
/// * A new witness to be added to a new global table.
///
/// * An existing witness to be removed from an existing global table.
///
/// You can configure one witness per MRSC global table.
pub const GlobalTableWitnessGroupUpdate = struct {
    /// Specifies a witness Region to be added to a new MRSC global table. The
    /// witness must be
    /// added when creating the MRSC global table.
    create: ?CreateGlobalTableWitnessGroupMemberAction,

    /// Specifies a witness Region to be removed from an existing global table. Must
    /// be done
    /// in conjunction with removing a replica. The deletion of both a witness and
    /// replica
    /// converts the remaining replica to a single-Region DynamoDB table.
    delete: ?DeleteGlobalTableWitnessGroupMemberAction,
};
