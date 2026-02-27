pub const NodeType = enum {
    data,
    ultrawarm,
    master,
    warm,

    pub const json_field_names = .{
        .data = "Data",
        .ultrawarm = "Ultrawarm",
        .master = "Master",
        .warm = "Warm",
    };
};
