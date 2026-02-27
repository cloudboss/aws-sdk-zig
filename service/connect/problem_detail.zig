/// Information about a problem detail.
pub const ProblemDetail = struct {
    /// The problem detail's message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
