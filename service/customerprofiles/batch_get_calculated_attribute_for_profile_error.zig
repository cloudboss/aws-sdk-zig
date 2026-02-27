/// Error object describing why a specific profile and calculated attribute
/// failed.
pub const BatchGetCalculatedAttributeForProfileError = struct {
    /// Status code for why a specific profile and calculated attribute failed.
    code: []const u8,

    /// Message describing why a specific profile and calculated attribute failed.
    message: []const u8,

    /// The profile id that failed.
    profile_id: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .profile_id = "ProfileId",
    };
};
