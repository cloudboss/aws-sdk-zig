pub const ControlSetStatus = enum {
    active,
    under_review,
    reviewed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .under_review = "UNDER_REVIEW",
        .reviewed = "REVIEWED",
    };
};
