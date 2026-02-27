pub const ShareStatus = enum {
    not_shared,
    shared_with_me,
    shared_by_me,

    pub const json_field_names = .{
        .not_shared = "NOT_SHARED",
        .shared_with_me = "SHARED_WITH_ME",
        .shared_by_me = "SHARED_BY_ME",
    };
};
