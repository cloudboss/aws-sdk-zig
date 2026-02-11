const CreateReplicaAction = @import("create_replica_action.zig").CreateReplicaAction;
const DeleteReplicaAction = @import("delete_replica_action.zig").DeleteReplicaAction;

/// Represents one of the following:
///
/// * A new replica to be added to an existing global table.
///
/// * New parameters for an existing replica.
///
/// * An existing replica to be removed from an existing global table.
pub const ReplicaUpdate = struct {
    /// The parameters required for creating a replica on an existing global table.
    create: ?CreateReplicaAction,

    /// The name of the existing replica to be removed.
    delete: ?DeleteReplicaAction,

    pub const json_field_names = .{
        .create = "Create",
        .delete = "Delete",
    };
};
