pub const FeedbackValue = enum {
    not_specified,
    useful,
    not_useful,

    pub const json_field_names = .{
        .not_specified = "NOT_SPECIFIED",
        .useful = "USEFUL",
        .not_useful = "NOT_USEFUL",
    };
};
