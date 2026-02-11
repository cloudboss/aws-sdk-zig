/// Represents a replica to be deleted.
pub const DeleteReplicationGroupMemberAction = struct {
    /// The Region where the replica exists.
    region_name: []const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};
