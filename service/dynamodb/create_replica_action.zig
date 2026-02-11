/// Represents a replica to be added.
pub const CreateReplicaAction = struct {
    /// The Region of the replica to be added.
    region_name: []const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};
