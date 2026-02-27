/// Contains information about a username hash that was successfully resolved in
/// a batch uname lookup operation.
pub const BatchUnameSuccessResponseItem = struct {
    /// The username hash that was successfully resolved.
    uname: []const u8,

    /// The email address or username corresponding to the username hash.
    username: []const u8,

    pub const json_field_names = .{
        .uname = "uname",
        .username = "username",
    };
};
