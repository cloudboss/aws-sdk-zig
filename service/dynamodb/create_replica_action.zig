/// Represents a replica to be added.
pub const CreateReplicaAction = struct {
    /// The Region of the replica to be added.
    region_name: []const u8,
};
