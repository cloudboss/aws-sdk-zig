/// The structure containing the session token being returned.
pub const Credentials = union(enum) {
    /// The actual session token being returned.
    token: ?[]const u8,

    pub const json_field_names = .{
        .token = "token",
    };
};
