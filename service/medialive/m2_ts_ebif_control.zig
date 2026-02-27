/// M2ts Ebif Control
pub const M2tsEbifControl = enum {
    none,
    passthrough,

    pub const json_field_names = .{
        .none = "NONE",
        .passthrough = "PASSTHROUGH",
    };
};
