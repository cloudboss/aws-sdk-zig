/// The details of a group in Amazon DataZone.
pub const GroupDetails = struct {
    /// The identifier of the group in Amazon DataZone.
    group_id: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
    };
};
