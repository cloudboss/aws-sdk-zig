pub const UsefulnessRating = enum {
    useful,
    not_useful,

    pub const json_field_names = .{
        .useful = "USEFUL",
        .not_useful = "NOT_USEFUL",
    };
};
