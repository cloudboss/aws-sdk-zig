/// Error object describing why a specific profile failed.
pub const BatchGetProfileError = struct {
    /// Status code for why a specific profile failed.
    code: []const u8,

    /// Message describing why a specific profile failed.
    message: []const u8,

    /// The profile id that failed.
    profile_id: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .profile_id = "ProfileId",
    };
};
