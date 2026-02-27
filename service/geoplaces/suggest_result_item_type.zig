pub const SuggestResultItemType = enum {
    place,
    query,

    pub const json_field_names = .{
        .place = "PLACE",
        .query = "QUERY",
    };
};
