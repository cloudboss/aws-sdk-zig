/// An error that occurred during a batch operation.
pub const BatchError = struct {
    /// The accessor identifier that's related to the error.
    accessor_id: []const u8,

    /// The error code.
    @"error": i32,

    /// Description of the error.
    message: []const u8,

    pub const json_field_names = .{
        .accessor_id = "accessorId",
        .@"error" = "error",
        .message = "message",
    };
};
