/// Burn In Background Color
pub const BurnInBackgroundColor = enum {
    black,
    none,
    white,

    pub const json_field_names = .{
        .black = "BLACK",
        .none = "NONE",
        .white = "WHITE",
    };
};
