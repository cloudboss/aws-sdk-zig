/// Contains error information for a username hash lookup that failed in a batch
/// uname lookup request.
pub const BatchUnameErrorResponseItem = struct {
    /// The field that caused the error.
    field: ?[]const u8 = null,

    /// A description of why the username hash lookup failed.
    reason: ?[]const u8 = null,

    /// The username hash that failed to be looked up.
    uname: []const u8,

    pub const json_field_names = .{
        .field = "field",
        .reason = "reason",
        .uname = "uname",
    };
};
