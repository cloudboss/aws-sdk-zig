/// Represents a replica to be removed.
pub const DeleteReplicaAction = struct {
    /// The Region of the replica to be removed.
    region_name: []const u8,
};
