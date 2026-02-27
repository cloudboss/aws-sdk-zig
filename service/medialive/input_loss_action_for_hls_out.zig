/// Input Loss Action For Hls Out
pub const InputLossActionForHlsOut = enum {
    emit_output,
    pause_output,

    pub const json_field_names = .{
        .emit_output = "EMIT_OUTPUT",
        .pause_output = "PAUSE_OUTPUT",
    };
};
