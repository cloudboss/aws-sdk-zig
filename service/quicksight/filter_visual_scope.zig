pub const FilterVisualScope = enum {
    all_visuals,
    selected_visuals,

    pub const json_field_names = .{
        .all_visuals = "ALL_VISUALS",
        .selected_visuals = "SELECTED_VISUALS",
    };
};
