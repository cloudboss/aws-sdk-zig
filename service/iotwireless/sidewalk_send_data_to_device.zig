const MessageType = @import("message_type.zig").MessageType;

/// Information about a Sidewalk router.
pub const SidewalkSendDataToDevice = struct {
    /// The duration of time in seconds to retry sending the ACK.
    ack_mode_retry_duration_secs: ?i32,

    message_type: ?MessageType,

    /// The sequence number.
    seq: ?i32,

    pub const json_field_names = .{
        .ack_mode_retry_duration_secs = "AckModeRetryDurationSecs",
        .message_type = "MessageType",
        .seq = "Seq",
    };
};
