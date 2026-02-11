/// Represents a replica to be removed.
pub const DeleteReplicaAction = struct {
    /// The Region of the replica to be removed.
    region_name: []const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};
