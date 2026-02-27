/// Input Loss Image Type
pub const InputLossImageType = enum {
    color,
    slate,

    pub const json_field_names = .{
        .color = "COLOR",
        .slate = "SLATE",
    };
};
