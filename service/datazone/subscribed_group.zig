/// The group that subscribes to the asset.
pub const SubscribedGroup = struct {
    /// The ID of the subscribed group.
    id: ?[]const u8 = null,

    /// The name of the subscribed group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
