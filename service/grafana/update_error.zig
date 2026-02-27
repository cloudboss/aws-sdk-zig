const UpdateInstruction = @import("update_instruction.zig").UpdateInstruction;

/// A structure containing information about one error encountered while
/// performing an
/// [UpdatePermissions](https://docs.aws.amazon.com/grafana/latest/APIReference/API_UpdatePermissions.html) operation.
pub const UpdateError = struct {
    /// Specifies which permission update caused the error.
    caused_by: UpdateInstruction,

    /// The error code.
    code: i32,

    /// The message for this error.
    message: []const u8,

    pub const json_field_names = .{
        .caused_by = "causedBy",
        .code = "code",
        .message = "message",
    };
};
