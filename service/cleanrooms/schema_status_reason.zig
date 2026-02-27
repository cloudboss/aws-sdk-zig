const SchemaStatusReasonCode = @import("schema_status_reason_code.zig").SchemaStatusReasonCode;

/// A reason why the schema status is set to its current value.
pub const SchemaStatusReason = struct {
    /// The schema status reason code.
    code: SchemaStatusReasonCode,

    /// An explanation of the schema status reason code.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
