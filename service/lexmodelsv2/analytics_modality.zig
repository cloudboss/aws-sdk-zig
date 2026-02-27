pub const AnalyticsModality = enum {
    speech,
    text,
    dtmf,
    multi_mode,

    pub const json_field_names = .{
        .speech = "Speech",
        .text = "Text",
        .dtmf = "DTMF",
        .multi_mode = "MultiMode",
    };
};
