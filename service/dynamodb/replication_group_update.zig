const CreateReplicationGroupMemberAction = @import("create_replication_group_member_action.zig").CreateReplicationGroupMemberAction;
const DeleteReplicationGroupMemberAction = @import("delete_replication_group_member_action.zig").DeleteReplicationGroupMemberAction;
const UpdateReplicationGroupMemberAction = @import("update_replication_group_member_action.zig").UpdateReplicationGroupMemberAction;

/// Represents one of the following:
///
/// * A new replica to be added to an existing regional table or global table.
///   This
/// request invokes the `CreateTableReplica` action in the destination
/// Region.
///
/// * New parameters for an existing replica. This request invokes the
/// `UpdateTable` action in the destination Region.
///
/// * An existing replica to be deleted. The request invokes the
/// `DeleteTableReplica` action in the destination Region, deleting
/// the replica and all if its items in the destination Region.
///
/// When you manually remove a table or global table replica, you do not
/// automatically
/// remove any associated scalable targets, scaling policies, or CloudWatch
/// alarms.
pub const ReplicationGroupUpdate = struct {
    /// The parameters required for creating a replica for the table.
    create: ?CreateReplicationGroupMemberAction,

    /// The parameters required for deleting a replica for the table.
    delete: ?DeleteReplicationGroupMemberAction,

    /// The parameters required for updating a replica for the table.
    update: ?UpdateReplicationGroupMemberAction,

    pub const json_field_names = .{
        .create = "Create",
        .delete = "Delete",
        .update = "Update",
    };
};
