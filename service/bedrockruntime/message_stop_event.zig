const StopReason = @import("stop_reason.zig").StopReason;

/// The stop event for a message.
pub const MessageStopEvent = struct {
    /// The additional model response fields.
    additional_model_response_fields: ?[]const u8 = null,

    /// The reason why the model stopped generating output.
    stop_reason: StopReason,

    pub const json_field_names = .{
        .additional_model_response_fields = "additionalModelResponseFields",
        .stop_reason = "stopReason",
    };
};
