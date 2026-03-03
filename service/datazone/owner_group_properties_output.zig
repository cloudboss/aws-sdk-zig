/// The properties of the domain unit owners group.
pub const OwnerGroupPropertiesOutput = struct {
    /// The ID of the domain unit owners group.
    group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "groupId",
    };
};
