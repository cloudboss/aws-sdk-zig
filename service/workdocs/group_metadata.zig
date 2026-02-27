/// Describes the metadata of a user group.
pub const GroupMetadata = struct {
    /// The ID of the user group.
    id: ?[]const u8,

    /// The name of the group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
