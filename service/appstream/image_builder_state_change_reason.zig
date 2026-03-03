const ImageBuilderStateChangeReasonCode = @import("image_builder_state_change_reason_code.zig").ImageBuilderStateChangeReasonCode;

/// Describes the reason why the last image builder state change occurred.
pub const ImageBuilderStateChangeReason = struct {
    /// The state change reason code.
    code: ?ImageBuilderStateChangeReasonCode = null,

    /// The state change reason message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
