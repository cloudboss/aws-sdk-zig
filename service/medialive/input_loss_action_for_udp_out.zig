/// Input Loss Action For Udp Out
pub const InputLossActionForUdpOut = enum {
    drop_program,
    drop_ts,
    emit_program,

    pub const json_field_names = .{
        .drop_program = "DROP_PROGRAM",
        .drop_ts = "DROP_TS",
        .emit_program = "EMIT_PROGRAM",
    };
};
