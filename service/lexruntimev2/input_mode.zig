pub const InputMode = enum {
    text,
    speech,
    dtmf,

    pub const json_field_names = .{
        .text = "TEXT",
        .speech = "SPEECH",
        .dtmf = "DTMF",
    };
};
