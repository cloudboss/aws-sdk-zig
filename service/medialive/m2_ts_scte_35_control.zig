/// M2ts Scte35 Control
pub const M2tsScte35Control = enum {
    none,
    passthrough,

    pub const json_field_names = .{
        .none = "NONE",
        .passthrough = "PASSTHROUGH",
    };
};
