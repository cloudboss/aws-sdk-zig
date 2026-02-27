pub const SearchAllRelatedItemsSortProperty = enum {
    association_time,
    case_id,

    pub const json_field_names = .{
        .association_time = "ASSOCIATION_TIME",
        .case_id = "CASE_ID",
    };
};
