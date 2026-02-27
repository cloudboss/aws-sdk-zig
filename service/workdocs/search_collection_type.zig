pub const SearchCollectionType = enum {
    owned,
    shared_with_me,

    pub const json_field_names = .{
        .owned = "OWNED",
        .shared_with_me = "SHARED_WITH_ME",
    };
};
