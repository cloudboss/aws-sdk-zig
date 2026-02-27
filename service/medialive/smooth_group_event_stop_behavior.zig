/// Smooth Group Event Stop Behavior
pub const SmoothGroupEventStopBehavior = enum {
    none,
    send_eos,

    pub const json_field_names = .{
        .none = "NONE",
        .send_eos = "SEND_EOS",
    };
};
