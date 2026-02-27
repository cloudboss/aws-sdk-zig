/// Details about a field that failed policy validation.
pub const ValidationExceptionField = struct {
    /// Describes the policy validation error.
    message: []const u8,

    /// The path to the specific element that Verified Permissions found to be not
    /// valid.
    path: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .path = "path",
    };
};
