pub const DeleteDomainResponse = struct {
    /// A message that indicates the delete request is done.
    message: []const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
