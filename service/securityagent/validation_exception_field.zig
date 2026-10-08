/// Describes one specific validation failure for an input member.
pub const ValidationExceptionField = struct {
    /// A detailed description of the validation failure.
    message: []const u8,

    /// A JSONPointer expression to the structure member whose value failed to
    /// satisfy the modeled constraint.
    path: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .path = "path",
    };
};
