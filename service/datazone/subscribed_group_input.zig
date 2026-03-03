/// The details of the subscribed group.
pub const SubscribedGroupInput = struct {
    /// The ID of the subscribed group.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
