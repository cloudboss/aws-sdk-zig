pub const ShareStatus = enum {
    not_shared,
    shared_with_me,
    shared_by_me,

    pub const json_field_names = .{
        .not_shared = "NotShared",
        .shared_with_me = "SharedWithMe",
        .shared_by_me = "SharedByMe",
    };
};
