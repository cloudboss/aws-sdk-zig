/// M2ts Klv
pub const M2tsKlv = enum {
    none,
    passthrough,

    pub const json_field_names = .{
        .none = "NONE",
        .passthrough = "PASSTHROUGH",
    };
};
