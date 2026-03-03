/// The subscribed user.
pub const SubscribedUserInput = struct {
    /// The ID of the subscribed user.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
