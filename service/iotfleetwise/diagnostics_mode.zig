pub const DiagnosticsMode = enum {
    off,
    send_active_dtcs,

    pub const json_field_names = .{
        .off = "OFF",
        .send_active_dtcs = "SEND_ACTIVE_DTCS",
    };
};
