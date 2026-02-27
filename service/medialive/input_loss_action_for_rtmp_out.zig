/// Input Loss Action For Rtmp Out
pub const InputLossActionForRtmpOut = enum {
    emit_output,
    pause_output,

    pub const json_field_names = .{
        .emit_output = "EMIT_OUTPUT",
        .pause_output = "PAUSE_OUTPUT",
    };
};
