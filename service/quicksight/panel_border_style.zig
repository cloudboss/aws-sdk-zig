pub const PanelBorderStyle = enum {
    solid,
    dashed,
    dotted,

    pub const json_field_names = .{
        .solid = "SOLID",
        .dashed = "DASHED",
        .dotted = "DOTTED",
    };
};
