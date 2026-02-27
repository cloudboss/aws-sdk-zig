pub const ControlStatus = enum {
    under_review,
    reviewed,
    inactive,

    pub const json_field_names = .{
        .under_review = "UNDER_REVIEW",
        .reviewed = "REVIEWED",
        .inactive = "INACTIVE",
    };
};
