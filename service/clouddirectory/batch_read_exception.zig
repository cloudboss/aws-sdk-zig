const BatchReadExceptionType = @import("batch_read_exception_type.zig").BatchReadExceptionType;

/// The batch read exception structure, which contains the exception type and
/// message.
pub const BatchReadException = struct {
    /// An exception message that is associated with the failure.
    message: ?[]const u8,

    /// A type of exception, such as `InvalidArnException`.
    @"type": ?BatchReadExceptionType,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
