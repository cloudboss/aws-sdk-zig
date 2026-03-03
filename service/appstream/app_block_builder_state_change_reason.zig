const AppBlockBuilderStateChangeReasonCode = @import("app_block_builder_state_change_reason_code.zig").AppBlockBuilderStateChangeReasonCode;

/// Describes the reason why the last app block builder state change occurred.
pub const AppBlockBuilderStateChangeReason = struct {
    /// The state change reason code.
    code: ?AppBlockBuilderStateChangeReasonCode = null,

    /// The state change reason message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
