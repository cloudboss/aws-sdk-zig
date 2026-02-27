/// Contains information for a group identity in an access policy.
pub const GroupIdentity = struct {
    /// The IAM Identity Center ID of the group.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
