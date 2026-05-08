/// Contains information about the Amazon Web Services account within which the
/// activity took place.
pub const Account = struct {
    /// Name of the member's Amazon Web Services account.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID within which the activity took place.
    /// This may differ from the account that owns the user identity.
    uid: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .uid = "Uid",
    };
};
