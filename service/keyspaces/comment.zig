/// An optional comment that describes the table.
pub const Comment = struct {
    /// An optional description of the table.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
