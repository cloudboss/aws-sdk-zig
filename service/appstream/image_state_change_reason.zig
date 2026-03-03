const ImageStateChangeReasonCode = @import("image_state_change_reason_code.zig").ImageStateChangeReasonCode;

/// Describes the reason why the last image state change occurred.
pub const ImageStateChangeReason = struct {
    /// The state change reason code.
    code: ?ImageStateChangeReasonCode = null,

    /// The state change reason message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
