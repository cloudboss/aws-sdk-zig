/// Burn In Shadow Color
pub const BurnInShadowColor = enum {
    black,
    none,
    white,

    pub const json_field_names = .{
        .black = "BLACK",
        .none = "NONE",
        .white = "WHITE",
    };
};
