/// Contains information about the account.
pub const Account = struct {
    /// Name of the member's Amazon Web Services account.
    name: ?[]const u8 = null,

    /// ID of the member's Amazon Web Services account
    uid: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .uid = "Uid",
    };
};
